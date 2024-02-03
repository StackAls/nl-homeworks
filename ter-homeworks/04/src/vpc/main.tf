terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  network_id     = yandex_vpc_network.develop.id
  name           = var.vpc_name
  zone           = var.vpc_zone
  v4_cidr_blocks = var.vpc_cidr
}