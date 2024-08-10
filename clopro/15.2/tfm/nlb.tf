resource "yandex_lb_network_load_balancer" "nlb-lamp" {
  name = "nlb-lamp"

  listener {
    name = "nlb-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
      address    = var.nat_ip_address
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.lamp-group.load_balancer.0.target_group_id
    healthcheck {
      name = "http-check"
      unhealthy_threshold = 5
      healthy_threshold   = 5
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}