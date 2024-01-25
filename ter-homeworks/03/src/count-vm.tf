resource "yandex_compute_instance" "platform" {
  name       = "web-${count.index + 1}"
  count      = 2
  depends_on = [yandex_compute_instance.platform-db]

  resources {
    cores         = var.vm_resources["web"].cores
    memory        = var.vm_resources["web"].memory
    core_fraction = var.vm_resources["web"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.vm_web_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = true
    # ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9AKvgJaAEuxZ1gVuXRMgWG2yeKdt2Kafmrkpot8Pks stack@StackNote"
    ssh-keys = local.ssh-keys
  }

}