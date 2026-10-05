provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.proxmox_api_token
  insecure  = true
}

resource "proxmox_virtual_environment_vm" "docker01" {
  name      = "docker01"
  node_name = "pve"
  vm_id     = 100

  on_boot       = false
  scsi_hardware = "virtio-scsi-single"

  agent {
    enabled = true
    timeout = "15m"
    type    = "virtio"
  }

  cpu {
    cores   = 2
    sockets = 1
    type    = "host"
  }

  memory {
    dedicated = 4096
  }

  operating_system {
    type = "l26"
  }

  network_device {
    bridge      = "vmbr0"
    firewall    = true
    model       = "virtio"
    mac_address = "BC:24:11:32:6C:51"
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 40
    iothread     = true
  }
}
