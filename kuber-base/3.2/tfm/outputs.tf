output "kuber" {
  value = [
    {
      master = [yandex_compute_instance.master[*].network_interface[0].nat_ip_address,
        yandex_compute_instance.master[*].network_interface[0].ip_address,
        yandex_compute_instance.master[*].fqdn,
    yandex_compute_instance.master[*].name] },
    { node = [yandex_compute_instance.node[*].network_interface[0].nat_ip_address,
      yandex_compute_instance.node[*].network_interface[0].ip_address,
      yandex_compute_instance.node[*].fqdn,
    yandex_compute_instance.node[*].name] }
  ]
}
