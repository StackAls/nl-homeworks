resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}

resource "yandex_compute_instance" "platform" {
  name = local.hostname-web
  platform_id = var.vm_web_platform_id
  # resources {
  #   cores         = var.vm_web_cores
  #   memory        = var.vm_web_memory
  #   core_fraction = var.vm_web_core_fraction
  # }
  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
  }
  # dynamic "resources" {
  #   for_each = var.vms_resources["web"]
  #   content {
  #     cores = setting.value["cores"]
  #     memory = setting.value["memory"]
  #     core_fraction = setting.value["core_fraction"]
  #   }
  # }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat
  }

  # metadata = {
  #   serial-port-enable = var.vm_web_serial-port-enable
  #   ssh-keys           = "${var.vm_web_vms_user_name}:${var.vms_ssh_root_key}"
  # }

  metadata = var.metadata["ssh-key"]

}

resource "yandex_vpc_subnet" "develop-b" {
  name           = var.vm_db_subset_name
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_db_cidr
}

resource "yandex_compute_instance" "platform2" {
  name = local.hostname-db
  platform_id = var.vm_db_platform_id
  zone        = var.vm_db_zone
  # resources {
  #   cores         = var.vm_db_cores
  #   memory        = var.vm_db_memory
  #   core_fraction = var.vm_db_core_fraction
  # }
  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-b.id
    nat       = var.vm_db_nat
  }

  # metadata = {
  #   serial-port-enable = var.vm_db_serial-port-enable
  #   ssh-keys           = "${var.vm_db_vms_user_name}:${var.vms_ssh_root_key}"
  # }
  metadata = var.metadata["ssh-key"]

}
