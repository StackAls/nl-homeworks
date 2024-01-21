###ssh vars

# variable "vms_ssh_root_key" {
#   type        = string
#   default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9AKvgJaAEuxZ1gVuXRMgWG2yeKdt2Kafmrkpot8Pks stack@StackNote"
#   description = "ssh-keygen -t ed25519"
# }

variable "metadata" {
  type    = map(object({
    serial-port-enable = bool
    ssh-keys = string
    }))
  default = {
    "ssh-key" = {
      serial-port-enable = true
      ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9AKvgJaAEuxZ1gVuXRMgWG2yeKdt2Kafmrkpot8Pks stack@StackNote"
    }
  }
}

### vm_web_

variable "vm_web_vms_user_name" {
  type = string
  default = "ubuntu"
}

variable "vm_web_image" {
  type = string
  default = "ubuntu-2004-lts"
}

# variable "vm_web_name" {
#     type = string
#     default = "netology-develop-platform-web"
# }

variable "vm_web_platform_id" {
    type = string
    default = "standard-v3"
}

# variable "vm_web_cores" {
#   type = number
#   default = 2
# }

# variable "vm_web_memory" {
#   type = number
#   default = 1
# }

# variable "vm_web_core_fraction" {
#   type = number
#   default = 20
# }

variable "vm_web_preemptible" {
  type = bool
  default = true
}

variable "vm_web_nat" {
  type = bool
  default = false
}

variable "vm_web_serial-port-enable" {
  type = bool
  default = true
}

### vm_db_

variable "vm_db_subset_name" {
  type = string
  default = "develop-b"
}

variable "vm_db_vms_user_name" {
  type = string
  default = "ubuntu"
}

variable "vm_db_image" {
  type = string
  default = "ubuntu-2004-lts"
}

# variable "vm_db_name" {
#     type = string
#     default = "netology-develop-platform-db"
# }

variable "vm_db_platform_id" {
    type = string
    default = "standard-v3"
}

variable "vm_db_zone" {
    type = string
    default = "ru-central1-b"
}

# variable "vm_db_cores" {
#   type = number
#   default = 2
# }

# variable "vm_db_memory" {
#   type = number
#   default = 2
# }

# variable "vm_db_core_fraction" {
#   type = number
#   default = 20
# }

variable "vm_db_preemptible" {
  type = bool
  default = true
}

variable "vm_db_cidr" {
  type = list(string)
  default = ["10.0.2.0/24"]
}

variable "vm_db_nat" {
  type = bool
  default = false
}

variable "vm_db_serial-port-enable" {
  type = bool
  default = true
}

variable "vms_resources" {
  type = map(object({
    cores = number
    memory  = number
    core_fraction = number
  }))
  default = {
     web={
       cores = 2
       memory = 1
       core_fraction = 20
     },
     db= {
       cores = 2
       memory = 2
       core_fraction = 20
     }
   }
}


