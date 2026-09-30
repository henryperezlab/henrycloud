# HenryCloud Network

## Network Overview

HenryCloud currently operates on a private IPv4 LAN.

| Component    | Address                  |
| ------------ | ------------------------ |
| Network      | `192.168.0.0/24`         |
| Gateway      | `192.168.0.1`            |
| Proxmox Host | `192.168.0.223`          |
| Docker VM    | `192.168.0.224`          |
| DNS          | `192.168.0.1`, `1.1.1.1` |

## Proxmox Network

The Proxmox host uses a Linux bridge:

```text
vmbr0
```

The bridge connects the Proxmox host and virtual machines to the physical LAN.

```text
LAN
192.168.0.0/24
      |
      |
  Gateway
 192.168.0.1
      |
      |
    vmbr0
      |
  +---+--------+
  |            |
 pve        docker01
 .223         .224
```

## Docker VM

The Debian VM `docker01` uses a static IPv4 configuration:

```text
Address: 192.168.0.224/24
Gateway: 192.168.0.1
DNS:     192.168.0.1
         1.1.1.1
```

The network interface is:

```text
ens18
```

## Current Access

Nextcloud is currently exposed on the LAN through:

```text
http://192.168.0.224:8080
```

This is a local/LAN deployment. HTTPS and a reverse proxy have not yet been implemented.

## Future Network Improvements

Planned network improvements include:

* Reverse proxy
* HTTPS
* DNS configuration
* Firewall rules
* Network segmentation
* Secure external access
* Monitoring
