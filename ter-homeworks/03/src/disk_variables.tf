variable "stor_disk_count" {
  type    = number
  default = 3
}
variable "stor_disk_type" {
  type    = string
  default = "network-hdd"
}

variable "stor_disk_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "stor_disk_size" {
  type    = number
  default = 1
}

variable "stor_auto_delete" {
  type    = bool
  default = true
}

variable "stor_nat" {
  type    = bool
  default = false
}

variable "stor_preemptible" {
  type    = bool
  default = true
}

variable "stor_serial_port" {
  type    = bool
  default = false
}

variable "stor_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default = {
    stor = {
      cores         = 2
      memory        = 1
      core_fraction = 20
    }
  }
}