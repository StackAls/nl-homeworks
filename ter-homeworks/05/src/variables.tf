variable "ip_address" {
  type        = string
  description="ip-адрес"
  default = "192.168.0.1"
  # default = "1920.1680.0.1"
  validation {
    condition = can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$",var.ip_address))
    error_message = "Invalid ip address"
  }

}

variable "ip_addresses" {
  type        = list(string)
  description="список ip-адресов"
  default = ["192.168.0.1", "1.1.1.1", "127.0.0.1"]
  # default = ["192.168.0.1", "1.1.1.1", "1270.0.0.1"]

  validation {
    condition = alltrue([
      for a in var.ip_addresses : can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$",a))
    ])
    error_message = "Invalid list ip addresses"
  }

}

variable "not_up_string" {
  type        = string
  description="любая строка"
  # default = "lowercase letters a-z0-9_-\\k// слово "
  default = "UppEr CasE"

  validation {
    condition = var.not_up_string == lower(var.not_up_string)
    error_message = "Only lowercase letter"
  }

}

variable "in_the_end_there_can_be_only_one" {
    description="Who is better Connor or Dunkan?"
    type = object({
        Dunkan = optional(bool)
        Connor = optional(bool)
    })

    default = {
        Dunkan = true
        Connor = false
    }

    # default = {
    #     Dunkan = true
    #     Connor = true
    # }
    # default = {
    #     Dunkan = false
    #     Connor = false
    # }

    validation {
        error_message = "There can be only one MacLeod"
        condition = (var.in_the_end_there_can_be_only_one.Dunkan == true && var.in_the_end_there_can_be_only_one.Connor == false) || (var.in_the_end_there_can_be_only_one.Dunkan == false && var.in_the_end_there_can_be_only_one.Connor == true)
    }
}

