terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_vpc_network" "develop" {
  count = var.vpc_name == "develop" ? 1 : 0
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  network_id     = yandex_vpc_network.develop[0].id
  count = var.vpc_name == "develop" ?  length(var.subnets) : 0
    name = "${var.vpc_name}-${var.subnets[count.index].zone}-[${var.subnets[count.index].cidr}]"
    zone = var.subnets[count.index].zone
    v4_cidr_blocks = ["${var.subnets[count.index].cidr}"]
  # for task 3
  # name           = var.vpc_name
  # zone           = var.vpc_zone
  # v4_cidr_blocks = var.vpc_cidr
}

resource "yandex_vpc_network" "prod" {
  count = var.vpc_name == "prod" ? 1 : 0
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "prod" {
  network_id     = yandex_vpc_network.prod[0].id
  count = var.vpc_name == "prod" ?  length(var.subnets) : 0
    name = "${var.vpc_name}-${var.subnets[count.index].zone}-[${var.subnets[count.index].cidr}]"
    zone = var.subnets[count.index].zone
    v4_cidr_blocks = ["${var.subnets[count.index].cidr}"]
  
}