###ssh vars

variable "metadata" {
  type = map(object({
    serial-port-enable = bool
    ssh-keys           = string
  }))
  default = {
    "ssh-key" = {
      serial-port-enable = true
      ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9AKvgJaAEuxZ1gVuXRMgWG2yeKdt2Kafmrkpot8Pks stack@StackNote"
      user-data          = "#cloud-config\nusers:\n  - name: admin\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9AKvgJaAEuxZ1gVuXRMgWG2yeKdt2Kafmrkpot8Pks stack@StackNote\n"
    }
  }
}

variable "vm_image" {
  type    = string
  default = "ubuntu-2004-lts"
}

# variable "vm_web_name" {
#     type = string
#     default = "netology-develop-platform-web"
# }

variable "vm_platform_id" {
  type    = string
  default = "standard-v3"
}

variable "vm_preemptible" {
  type    = bool
  default = true
}

variable "vm_nat" {
  type    = bool
  default = true
}

variable "vm_serial-port-enable" {
  type    = bool
  default = true
}

variable "vm_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    disk_size     = number
  }))
  default = {
    master = {
      cores         = 4
      memory        = 4
      core_fraction = 20
      disk_size     = 30
    },
    node = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      disk_size     = 30
    }
  }
}


