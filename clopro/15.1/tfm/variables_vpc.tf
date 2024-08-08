variable "vpc_public" {
  type        = string
  default     = "public"
  description = "VPC network & subnet name"
}

variable "vpc_public_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_private" {
  type    = string
  default = "private"
}

variable "vpc_private_cidr" {
  type    = list(string)
  default = ["192.168.20.0/24"]
}