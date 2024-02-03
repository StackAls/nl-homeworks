resource "yandex_compute_instance" "storage" {

  name = "storage"
  resources {
    cores         = var.stor_resources["stor"].cores
    memory        = var.stor_resources["stor"].memory
    core_fraction = var.stor_resources["stor"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = var.stor_preemptible
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.stor_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = var.stor_serial_port
    ssh-keys           = local.ssh-keys
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disks_storage
    content {
      disk_id     = secondary_disk.value.id
      device_name = secondary_disk.value.name
      auto_delete = var.stor_auto_delete
    }
  }

}

resource "yandex_compute_disk" "disks_storage" {
  count = var.stor_disk_count
  name  = "disk-${count.index}"
  type  = var.stor_disk_type
  zone  = var.stor_disk_zone
  size  = var.stor_disk_size
}
