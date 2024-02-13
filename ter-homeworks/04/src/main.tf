# resource "yandex_vpc_network" "develop" {
#   name = var.vpc_name
# }

# resource "yandex_vpc_subnet" "develop" {
#   name           = var.vpc_name
#   zone           = var.default_zone
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = var.default_cidr
# }

module "vpc_prod" {
  source   = "./vpc/"
  vpc_name = "prod"
  # vpc_zone = var.default_zone
  # vpc_cidr = var.default_cidr
  subnets = [{ zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}

module "vpc_dev" {
  source   = "./vpc/"
  vpc_name = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}

module "marketing" {
  source   = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=27e2c4923ec1c7c451c3daa965676ca037cecfb5"
  env_name = var.marketing
  # network_id     = yandex_vpc_network.develop.id
  network_id   = module.vpc_prod.network_id_prod[0]
  subnet_zones = [var.default_zone]
  # subnet_ids     = [yandex_vpc_subnet.develop.id]
  subnet_ids     = [module.vpc_prod.subnet_id_prod[0]]
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
  source   = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=27e2c4923ec1c7c451c3daa965676ca037cecfb5"
  env_name = var.analytics
  # network_id     = yandex_vpc_network.develop.id
  network_id   = module.vpc_prod.network_id_prod[0]
  subnet_zones = [var.default_zone]
  # subnet_ids     = [yandex_vpc_subnet.develop.id]
  subnet_ids     = [module.vpc_prod.subnet_id_prod[0]]
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
