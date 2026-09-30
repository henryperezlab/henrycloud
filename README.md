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
* Security
* Automation
* Monitoring
* Backup and recovery

The project is built incrementally, documenting the actual infrastructure and configuration at each stage.

## Current Architecture

```text
                         LAN
                          │
                          ▼
                    ┌───────────┐
                    │  Proxmox  │
                    │    pve    │
                    └─────┬─────┘
                          │
                    Debian 13 VM
                       docker01
                    192.168.0.224
                          │
                       Docker
                          │
              ┌───────────┴───────────┐
              │                       │
        ┌─────▼─────┐           ┌─────▼─────┐
        │ Nextcloud │           │ PostgreSQL│
        │  35.0.1   │           │   17.11   │
        └─────┬─────┘           └───────────┘
              │
        Persistent Data
              │
        Backup Repository
```

The architecture will evolve as additional services are implemented.

## Infrastructure

### Proxmox Host

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

### Docker VM

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

## Docker

Docker is running on the Debian VM.

| Component      | Version |
| -------------- | ------- |
| Docker Engine  | 29.8.1  |
| Docker Compose | 5.5.1   |
| containerd     | 2.3.6   |
| Buildx         | 0.37.1  |

Docker Compose is used to manage the HenryCloud services.

## Current Services

### Nextcloud

Nextcloud is currently deployed as a Docker container.

* Version: **35.0.1**
* Web server: Apache
* PHP: 8.5
* Access: LAN
* Persistent application data stored under `/opt/henrycloud/data/nextcloud`

### PostgreSQL

PostgreSQL is currently deployed as a Docker container and is used as the Nextcloud database.

* Version: **17.11**
* Database: `nextcloud`
* User: `nextcloud`
* Persistent database data stored under `/opt/henrycloud/data/postgres`

## Project Structure

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

## Backup

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

##  Security

Security is treated as an integral part of the project.

Current practices include:

* Secrets stored outside the Git repository
* Restricted permissions on secret files
* Persistent application data stored outside the Git repository
* Regular system updates
* Docker service isolation
* Backup of application data and database

Planned security improvements include:

* Firewall configuration
* HTTPS
* Reverse proxy
* Authentication hardening
* Network segmentation
* Monitoring and alerting
* Security auditing

**No passwords, private keys, API tokens or other secrets are stored in this repository.**

## Monitoring

Monitoring is planned for a future stage.

The goal is to monitor:

* System resources
* Docker containers
* Service availability
* Logs
* Storage usage
* Alerts

## Roadmap

### Completed

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

### In Progress / Planned

* [ ] Document infrastructure configuration
* [ ] Reverse proxy
* [ ] HTTPS
* [ ] OnlyOffice
* [ ] Monitoring
* [ ] Automated backups
* [ ] Restore testing
* [ ] Security hardening
* [ ] Automation
* [ ] CI/CD
* [ ] Infrastructure as Code

## Author

**Henry Pérez**

Network Administration • Infrastructure • DevOps • Automation • AI

GitHub: [@henryperezlab](https://github.com/henryperezlab)

---

> **Build it. Document it. Automate it. Improve it.**
