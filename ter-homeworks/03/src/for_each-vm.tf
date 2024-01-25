resource "yandex_compute_instance" "platform-db" {

  for_each = {
    for vm in var.each_vm :
    vm.vm_name => vm
  }

  name = each.value.vm_name
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_size
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
    serial-port-enable = each.value.serial_port
    ssh-keys           = local.ssh-keys
  }

}