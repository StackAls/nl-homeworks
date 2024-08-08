data "yandex_compute_image" "ubuntu" {
  family = var.vm_image
}

resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_compute_instance" "master" {
  name        = "master"
  platform_id = var.vm_platform_id
  resources {
    cores         = var.vm_resources["master"].cores
    memory        = var.vm_resources["master"].memory
    core_fraction = var.vm_resources["master"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm_resources["master"].disk_size
    }
  }
  scheduling_policy {
    preemptible = var.vm_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_nat
  }

  metadata = var.metadata["ssh-key"]

}

resource "yandex_compute_instance" "node" {
  name        = "node-${count.index + 1}"
  count       = 4
  platform_id = var.vm_platform_id
  zone        = var.default_zone

  resources {
    cores         = var.vm_resources["node"].cores
    memory        = var.vm_resources["node"].memory
    core_fraction = var.vm_resources["node"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm_resources["node"].disk_size
    }
  }
  scheduling_policy {
    preemptible = var.vm_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_nat
  }

  metadata = var.metadata["ssh-key"]

}
