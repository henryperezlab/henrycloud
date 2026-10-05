# HenryCloud

**Self-hosted cloud infrastructure built with Proxmox, Debian, Docker, PostgreSQL and Nextcloud.**

> **Build it. Document it. Automate it. Improve it.**

## Objective

HenryCloud is a personal infrastructure project created to learn, implement and document real-world technologies related to:

* Linux
* Networking
* Virtualization
* Docker
* Cloud infrastructure
* Infrastructure as Code
* Configuration Management
* Security
* Automation
* Monitoring
* Backup and recovery
* CI/CD

The project is built incrementally, documenting the actual infrastructure and configuration at each stage.

The long-term goal is to transform the environment into a reproducible, automated and documented infrastructure platform.

---

# Architecture

```text
                         GitHub
                           │
                           │
                    GitHub Actions
                    (future CI/CD)
                           │
              ┌────────────┴────────────┐
              │                         │
          Terraform                  Ansible
              │                         │
              ▼                         ▼
        ┌───────────┐             ┌───────────┐
        │ Proxmox   │             │ docker01  │
        │    pve    │────────────▶│ Debian 13 │
        └───────────┘             └─────┬─────┘
                                        │
                                      Docker
                                        │
                          ┌─────────────┴─────────────┐
                          │                           │
                    ┌─────▼─────┐               ┌─────▼─────┐
                    │ Nextcloud │               │ PostgreSQL│
                    │  35.0.1   │               │   17.11   │
                    └─────┬─────┘               └───────────┘
                          │
                    Persistent Data
                          │
                    Backup Repository
```

### Infrastructure workflow

```text
Terraform
    │
    └── Infrastructure provisioning / management
                │
                ▼
             Proxmox
                │
                ▼
             docker01
                │
                ▼
             Ansible
                │
                └── System configuration / automation
                            │
                            ▼
                         Docker
                            │
                    ┌───────┴───────┐
                    │               │
                Nextcloud       PostgreSQL
```

The architecture will evolve as additional services and automation are implemented.

---

# Infrastructure

## Proxmox Host

| Component  | Value               |
| ---------- | ------------------- |
| Hypervisor | Proxmox VE 9.2.2    |
| Hostname   | `pve`               |
| Hardware   | Dell Latitude 3330  |
| CPU        | Intel Core i3-3217U |
| CPU        | 2 cores / 4 threads |
| RAM        | ~8 GB               |
| Storage    | ~224 GB             |
| Network    | `192.168.0.0/24`    |
| Proxmox IP | `192.168.0.223`     |

## Docker VM

| Component        | Value              |
| ---------------- | ------------------ |
| VM ID            | `100`              |
| Hostname         | `docker01`         |
| Operating System | Debian 13 (Trixie) |
| vCPU             | 2                  |
| RAM              | 4 GB               |
| Disk             | 40 GB              |
| IP Address       | `192.168.0.224/24` |
| Gateway          | `192.168.0.1`      |

The virtual machine is managed by Proxmox and configured through Infrastructure as Code using Terraform.

---

# Infrastructure as Code

## Terraform

Terraform is used to describe and manage the Proxmox infrastructure.

Current implementation:

* Terraform **1.16.5**
* Provider: `bpg/proxmox`
* Proxmox VM managed: `docker01`
* VM ID: `100`
* Proxmox node: `pve`

The existing `docker01` virtual machine was imported into Terraform instead of being recreated.

```text
Terraform
    │
    ▼
Proxmox API
    │
    ▼
VM 100 - docker01
```

Terraform state is intentionally excluded from Git.

Sensitive variables and credentials are also excluded from the repository.

### Terraform structure

```text
terraform/
├── main.tf
├── outputs.tf
├── variables.tf
├── version.tf
├── .gitignore
└── .terraform.lock.hcl
```

The current Terraform configuration has been validated with:

```text
terraform plan
```

Result:

```text
No changes. Your infrastructure matches the configuration.
```

---

# Configuration Management

## Ansible

Ansible is used for configuration management and automation of the Debian VM.

Current implementation provides:

* SSH key-based authentication
* Inventory management
* Automatic system fact gathering
* Infrastructure discovery
* Remote execution
* Idempotent automation foundation

Current managed host:

```text
docker01
192.168.0.224
```

### Ansible structure

```text
ansible/
├── ansible.cfg
├── inventory/
│   └── hosts.yml
├── playbooks/
│   └── site.yml
└── roles/
```

### Current inventory

```text
all
└── docker
    └── docker01
```

### Current automation

The first Ansible playbook performs system discovery and reports:

* Hostname
* Operating system
* Kernel
* CPU
* Memory
* IPv4 address
* Root filesystem capacity

Example result:

```text
Hostname: docker01
OS: Debian 13.7
Kernel: 6.12.111+deb13-amd64
CPU cores: 2
Memory: 3921 MB
IPv4: 192.168.0.224
Disk /: 37 GB
```

Future Ansible automation will manage Docker, system configuration, security hardening and application services.

---

# Docker

Docker is running on the Debian VM `docker01`.

| Component      | Version |
| -------------- | ------- |
| Docker Engine  | 29.8.1  |
| Docker Compose | 5.5.1   |
| containerd     | 2.3.6   |
| Buildx         | 0.37.1  |

Docker Compose is used to manage the HenryCloud application services.

Future automation will progressively move Docker configuration and service management into Ansible.

---

# Current Services

## Nextcloud

Nextcloud is currently deployed as a Docker container.

* Version: **35.0.1**
* Web server: Apache
* PHP: 8.5
* Access: LAN
* Persistent application data stored under `/opt/henrycloud/data/nextcloud`

## PostgreSQL

PostgreSQL is currently deployed as a Docker container and is used as the Nextcloud database.

* Version: **17.11**
* Database: `nextcloud`
* User: `nextcloud`
* Persistent database data stored under `/opt/henrycloud/data/postgres`

---

# Project Structure

## Repository

```text
henrycloud/
├── ansible/
│   ├── ansible.cfg
│   ├── inventory/
│   │   └── hosts.yml
│   ├── playbooks/
│   │   └── site.yml
│   └── roles/
│
├── docs/
│   └── infrastructure/
│       └── network.md
│
├── terraform/
│   ├── main.tf
│   ├── outputs.tf
│   ├── variables.tf
│   ├── version.tf
│   ├── .gitignore
│   └── .terraform.lock.hcl
│
├── .gitignore
└── README.md
```

## Application data

Application data lives on the Docker VM:

```text
/opt/henrycloud/
├── backups/
│   └── initial/
├── compose/
│   └── docker-compose.yml
├── config/
├── data/
│   ├── nextcloud/
│   └── postgres/
├── secrets/
│   ├── nextcloud.env
│   └── postgres.env
└── .gitignore
```

Sensitive information and application data are intentionally excluded from Git.

---

# Backup

An initial backup has been created containing:

* PostgreSQL logical database dump
* Nextcloud application/data files

Backup integrity has been verified.

Future work will include:

* Automated backups
* Backup scheduling
* Restore testing
* Retention policies
* Disaster recovery procedures

---

# Security

Security is treated as an integral part of the project.

Current practices include:

* Secrets stored outside the Git repository
* Restricted permissions on secret files
* Persistent application data stored outside the Git repository
* SSH key-based authentication for Ansible
* Regular system updates
* Docker service isolation
* Backup of application data and database
* Terraform credentials managed outside the repository

Planned security improvements include:

* Firewall configuration
* HTTPS
* Reverse proxy
* Authentication hardening
* Network segmentation
* Monitoring and alerting
* Security auditing
* Secrets management

**No passwords, private keys, API tokens or other secrets are stored in this repository.**

---

# Monitoring

Monitoring is planned for a future stage.

The goal is to monitor:

* System resources
* Docker containers
* Service availability
* Logs
* Storage usage
* Alerts

---

# Roadmap

## Completed

* [x] Create GitHub repository
* [x] Create project documentation
* [x] Deploy Proxmox VE
* [x] Create Debian Docker VM
* [x] Configure static network
* [x] Install Docker Engine
* [x] Install Docker Compose
* [x] Deploy PostgreSQL
* [x] Deploy Nextcloud
* [x] Configure persistent storage
* [x] Create initial backups
* [x] Verify database connectivity
* [x] Verify backup integrity
* [x] Document infrastructure configuration
* [x] Implement Terraform
* [x] Import existing VM into Terraform
* [x] Validate Terraform configuration
* [x] Implement Ansible
* [x] Configure Ansible inventory
* [x] Configure SSH key authentication
* [x] Implement system discovery playbook
* [x] Validate Ansible connectivity

## In Progress

* [ ] Automate Docker configuration with Ansible
* [ ] Manage Docker services with Ansible
* [ ] Improve infrastructure documentation
* [ ] Add infrastructure validation

## Planned

* [ ] Reverse proxy
* [ ] HTTPS
* [ ] OnlyOffice
* [ ] Monitoring
* [ ] Automated backups
* [ ] Restore testing
* [ ] Security hardening
* [ ] Network segmentation
* [ ] Secrets management
* [ ] CI/CD with GitHub Actions
* [ ] Automated infrastructure deployment
* [ ] Disaster recovery testing

---

# Technologies

| Area                     | Technology                                    |
| ------------------------ | --------------------------------------------- |
| Hypervisor               | Proxmox VE                                    |
| Operating System         | Debian Linux                                  |
| Infrastructure as Code   | Terraform                                     |
| Configuration Management | Ansible                                       |
| Containers               | Docker                                        |
| Container Orchestration  | Docker Compose                                |
| Database                 | PostgreSQL                                    |
| Cloud Platform           | Nextcloud                                     |
| Version Control          | Git / GitHub                                  |
| CI/CD                    | GitHub Actions *(planned)*                    |
| Networking               | TCP/IP, Linux networking                      |
| Security                 | SSH, firewall, secrets management *(planned)* |

---

# Author

**Henry Pérez**

Network Administration • Infrastructure • DevOps • Automation • AI

GitHub: [@henryperezlab](https://github.com/henryperezlab)

---

> **Build it. Document it. Automate it. Improve it.**
