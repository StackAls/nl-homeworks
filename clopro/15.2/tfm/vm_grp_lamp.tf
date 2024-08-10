resource "yandex_iam_service_account" "ig-sa" {
  name = "ig-sa"
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
}

resource "yandex_compute_instance_group" "lamp-group" {
  name               = "lamp-group"
  service_account_id = yandex_iam_service_account.ig-sa.id
  instance_template {
    platform_id = var.vm_platform_id
    resources {
      cores         = var.vm_resources["lamp"].cores
      memory        = var.vm_resources["lamp"].memory
      core_fraction = var.vm_resources["lamp"].core_fraction
    }
    boot_disk {
      initialize_params {
        image_id = yandex_compute_image.vm-lamp-image.id
        size     = var.vm_resources["lamp"].disk_size
      }
    }
    network_interface {
      subnet_ids = [yandex_vpc_subnet.public.id]
      # ip_address     = var.vm_lamp_ip_address
      nat = var.vm_nat_enable
      # nat_ip_address = var.lamp_ip_address
    }
    scheduling_policy {
      preemptible = var.vm_preemptible
    }

    metadata = {
      user-data = "${file("${path.module}/cloud-init.yml")}"
      ssh-keys  = var.ssh-keys
    }
  }

  allocation_policy {
    zones = [var.default_zone]
  }

  deploy_policy {
    max_unavailable = var.lamp_max_unavailable
    max_expansion   = var.lamp_max_expansion
  }

  scale_policy {
    fixed_scale {
      size = var.lamp_scale_size
    }
  }

  health_check {
    interval            = var.lamp_health_interval
    timeout             = var.lamp_health_timeout
    healthy_threshold   = var.lamp_health_threshold
    unhealthy_threshold = var.lamp_health_unhealthy_threshold
    tcp_options {
      port = var.lamp_health_port
    }
  }

  # load_balancer {
  #   target_group_name = "lamp-nlb-grp"
  # }

  application_load_balancer {
    target_group_name = "alb-tg"
  }
}