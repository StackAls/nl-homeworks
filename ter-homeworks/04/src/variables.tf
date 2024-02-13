###cloud vars
# variable "token" {
#   type        = string
#   description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
# }

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "image_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

locals {
  ssh-keys = file("~/.ssh/nl-ya-ed25519.pub")
}

variable "analytics" {
  type    = string
  default = "analytics"
}

variable "marketing" {
  type    = string
  default = "marketing"
}