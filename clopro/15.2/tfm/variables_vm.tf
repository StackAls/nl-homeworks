###ssh vars

variable "metadata" {
  type = map(object({
    serial-port-enable = bool
    ssh-keys           = string
    user-data          = string
  }))
  default = {
    "ssh-key" = {
      serial-port-enable = true
      ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9AKvgJaAEuxZ1gVuXRMgWG2yeKdt2Kafmrkpot8Pks stack@StackNote"
      user-data          = "#cloud-config\nusers:\n  - name: admin\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9AKvgJaAEuxZ1gVuXRMgWG2yeKdt2Kafmrkpot8Pks stack@StackNote\n"
    }
  }
}

variable "ssh-keys" {
  type    = string
  default = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9AKvgJaAEuxZ1gVuXRMgWG2yeKdt2Kafmrkpot8Pks stack@StackNote"
}

variable "nat_ip_address" {
  type    = string
  default = "178.154.205.25"
}

variable "vm_nat_image_id" {
  type    = string
  default = "fd80mrhj8fl2oe87o4e1"
}

resource "yandex_compute_image" "vm-lamp-image" {
  source_family = var.vm_lamp_image_family
}

variable "vm_lamp_image_family" {
  type    = string
  default = "lamp"
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
    },
    lamp = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      disk_size     = 30
    }
  }
}

# LAMP grp https://terraform-provider.yandexcloud.net//Resources/compute_instance_group

variable "lamp_scale_size" {
  type    = number
  default = 3
}

variable "lamp_max_unavailable" {
  type    = number
  default = 2
}

variable "lamp_max_expansion" {
  type    = number
  default = 1
}

variable "lamp_health_port" {
  type    = number
  default = 80
}

variable "lamp_health_interval" {
  type    = number
  default = 30
}

variable "lamp_health_timeout" {
  type    = number
  default = 5
}

variable "lamp_health_threshold" {
  type    = number
  default = 2
}

variable "lamp_health_unhealthy_threshold" {
  type    = number
  default = 2
}
