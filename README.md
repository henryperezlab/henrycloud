# HenryCloud ☁️

**Self-hosted cloud infrastructure built with Proxmox, Docker, Nextcloud and OnlyOffice.**

## 🎯 Objective

HenryCloud is a personal infrastructure project created to learn, implement and document real-world technologies related to:

* Linux
* Networking
* Proxmox
* Docker
* Cloud infrastructure
* Security
* Automation
* Monitoring
* Backup and recovery

## 🏗️ Architecture

```text
                         INTERNET
                            │
                            ▼
                       DNS / HTTPS
                            │
                            ▼
                     Reverse Proxy
                            │
                            ▼
                       PROXMOX
                            │
                         Docker
                            │
              ┌─────────────┼─────────────┐
              │             │             │
          Nextcloud      OnlyOffice    Database
              │
              ▼
           Storage
              │
           Backups
```

> The architecture will evolve as the project grows.

## 🧰 Technologies

| Technology     | Purpose                           |
| -------------- | --------------------------------- |
| Proxmox VE     | Virtualization                    |
| Linux          | Operating system                  |
| Docker         | Containerization                  |
| Docker Compose | Container orchestration           |
| Nextcloud      | Private cloud                     |
| OnlyOffice     | Online document editing           |
| PostgreSQL     | Database                          |
| DNS            | Name resolution                   |
| HTTPS          | Secure communication              |
| GitHub         | Version control and documentation |

## 🔐 Security

Security is a fundamental part of this project.

The documentation will cover:

* Firewall configuration
* HTTPS
* Authentication
* Access control
* Network security
* Updates
* Backup and recovery
* Secrets management

**No passwords, private keys, API tokens or other secrets will be stored in this repository.**

## 📊 Monitoring

Planned monitoring:

* System resources
* Container health
* Service availability
* Logs
* Alerts

## 💾 Backup

The project will document:

* Backup strategy
* Backup frequency
* Recovery procedures
* Disaster recovery

## 🚀 Roadmap

* [x] Create GitHub repository
* [x] Create project documentation
* [ ] Document current infrastructure
* [ ] Docker Compose
* [ ] Reverse proxy
* [ ] HTTPS
* [ ] Monitoring
* [ ] Backup strategy
* [ ] Security hardening
* [ ] Automation
* [ ] CI/CD

## 👨‍💻 Author

**Henry Pérez**

Network Administration • Infrastructure • DevOps • Automation • AI

GitHub: [@henryperezlab](https://github.com/henryperezlab)

---

> **Build it. Document it. Automate it. Improve it.**
