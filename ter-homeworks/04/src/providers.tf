terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.107.0"
    }
    template = {
      source = "hashicorp/template"
      version = "~> 0.1"
    }
    vault = {
      source = "hashicorp/vault"
      version = "3.24.0"
    }
  }
  required_version = ">=0.13"

  backend "s3" {
    endpoint          = "storage.yandexcloud.net"
    bucket            = "stackals"
    region            = "ru-central1"
    key               = "terraform/terraform.tfstate"
    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gqm1iol4i36qcf7cbn/etnavhfjj0tfg9ub9s7r"
    dynamodb_table    = "state-lock-db"

    profile = "dev"

    skip_region_validation      = true
    skip_credentials_validation = true
  }

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

