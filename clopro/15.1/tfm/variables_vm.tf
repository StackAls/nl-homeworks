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

variable "nat_ip_address" {
  type    = string
  default = "178.154.205.25"
}

variable "vm_nat_image_id" {
  type    = string
  default = "fd80mrhj8fl2oe87o4e1"
}

variable "vm_nat_ip_address" {
  type    = string
  default = "192.168.10.254"
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_image
}

variable "vm_image" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "vm_platform_id" {
  type    = string
  default = "standard-v3"
}

# прерываемая
variable "vm_preemptible" {
  type    = bool
  default = true
}

# внешний ip
variable "vm_nat_enable" {
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
    nat = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      disk_size     = 30
    },
    public = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      disk_size     = 30
    },
    private = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      disk_size     = 30
    }
  }
}


