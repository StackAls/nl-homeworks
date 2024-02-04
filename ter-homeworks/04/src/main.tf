# resource "yandex_vpc_network" "develop" {
#   name = var.vpc_name
# }

# resource "yandex_vpc_subnet" "develop" {
#   name           = var.vpc_name
#   zone           = var.default_zone
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = var.default_cidr
# }

module "vpc" {
  source   = "./vpc/"
  vpc_name = var.vpc_name
  vpc_zone = var.default_zone
  vpc_cidr = var.default_cidr
}

module "marketing" {
  source   = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name = var.marketing
  # network_id     = yandex_vpc_network.develop.id
  network_id   = module.vpc.network_id
  subnet_zones = [var.default_zone]
  # subnet_ids     = [yandex_vpc_subnet.develop.id]
  subnet_ids     = [module.vpc.subnet_id]
  instance_name  = "web"
  instance_count = 1
  image_family   = var.image_family
  public_ip      = true

  labels = {
    env = var.marketing
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

module "analytics" {
  source   = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name = var.analytics
  # network_id     = yandex_vpc_network.develop.id
  network_id   = module.vpc.network_id
  subnet_zones = [var.default_zone]
  # subnet_ids     = [yandex_vpc_subnet.develop.id]
  subnet_ids     = [module.vpc.subnet_id]
  instance_name  = "web"
  instance_count = 1
  image_family   = var.image_family
  public_ip      = true

  labels = {
    env = var.analytics
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

data "template_file" "cloudinit" {
  template = file("${path.module}/cloud-init.yml.tftpl")
  vars = {
    ssh_public_key = local.ssh-keys
  }
}
