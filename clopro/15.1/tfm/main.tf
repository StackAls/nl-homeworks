resource "yandex_vpc_network" "network" {
  name = "network"
}

resource "yandex_vpc_subnet" "public" {
  network_id     = yandex_vpc_network.network.id
  name           = var.vpc_public
  zone           = var.default_zone
  v4_cidr_blocks = var.vpc_public_cidr
}

resource "yandex_vpc_subnet" "private" {
  network_id     = yandex_vpc_network.network.id
  name           = var.vpc_private
  zone           = var.default_zone
  v4_cidr_blocks = var.vpc_private_cidr
  route_table_id = yandex_vpc_route_table.route_nat.id
}

resource "yandex_vpc_route_table" "route_nat" {
  network_id = yandex_vpc_network.network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.vm_nat_ip_address
  }

}

resource "yandex_compute_instance" "nat" {
  name                      = "nat"
  platform_id               = var.vm_platform_id
  zone                      = var.default_zone
  allow_stopping_for_update = true

  resources {
    cores         = var.vm_resources["nat"].cores
    memory        = var.vm_resources["nat"].memory
    core_fraction = var.vm_resources["nat"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.vm_nat_image_id
      size     = var.vm_resources["nat"].disk_size
    }
  }
  scheduling_policy {
    preemptible = var.vm_preemptible
  }
  network_interface {
    subnet_id      = yandex_vpc_subnet.public.id
    ip_address     = var.vm_nat_ip_address
    nat            = var.vm_nat_enable
    nat_ip_address = var.nat_ip_address

  }

  metadata = var.metadata["ssh-key"]

}

resource "yandex_compute_instance" "public" {
  name        = "public"
  platform_id = var.vm_platform_id
  zone        = var.default_zone

  resources {
    cores         = var.vm_resources["public"].cores
    memory        = var.vm_resources["public"].memory
    core_fraction = var.vm_resources["public"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm_resources["public"].disk_size
    }
  }
  scheduling_policy {
    preemptible = var.vm_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = var.vm_nat_enable
  }

  metadata = var.metadata["ssh-key"]

}

resource "yandex_compute_instance" "private" {
  name        = "private"
  platform_id = var.vm_platform_id
  zone        = var.default_zone

  resources {
    cores         = var.vm_resources["private"].cores
    memory        = var.vm_resources["private"].memory
    core_fraction = var.vm_resources["private"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm_resources["private"].disk_size
    }
  }
  scheduling_policy {
    preemptible = var.vm_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
  }

  metadata = var.metadata["ssh-key"]

}
