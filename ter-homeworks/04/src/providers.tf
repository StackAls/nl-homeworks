terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}

provider "yandex" {
  # token     = var.token
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
  service_account_key_file = file("../../../../authorized_key.json")
}

# provider "aws" {
#   skip_region_validation      = true
#   skip_credentials_validation = true
#   skip_requesting_account_id  = true
# }

provider "vault" {
  address         = "http://127.0.0.1:8200"
  skip_tls_verify = true
  token           = "education"
  # checkov:skip=CKV_SECRET_6: education
}