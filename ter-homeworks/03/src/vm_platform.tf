variable "vm_web_vms_user_name" {
  type    = string
  default = "ubuntu"
}

variable "vm_web_image" {
  type    = string
  default = "ubuntu-2004-lts"
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}

variable "vm_web_platform_id" {
  type    = string
  default = "standard-v3"
}

variable "vm_web_preemptible" {
  type    = bool
  default = true
}

variable "vm_web_nat" {
  type    = bool
  default = true
}

variable "vm_web_serial-port-enable" {
  type    = bool
  default = true
}

variable "vm_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 20
    }
  }
}

variable "core_fraction" {
  type    = number
  default = 20
}

variable "each_vm" {
  type = list(object({
    vm_name     = string,
    cpu         = number,
    ram         = number,
    disk_size   = number,
    serial_port = bool
  }))
  default = [
    {
      vm_name     = "main"
      cpu         = 4
      ram         = 2
      disk_size   = 15
      serial_port = false
    },
    {
      vm_name     = "replica"
      cpu         = 2
      ram         = 1
      disk_size   = 20
      serial_port = true
    }
  ]
}

locals {
  ssh-keys = "ubuntu:${file("~/.ssh/nl-ya-ed25519.pub")}"
}
