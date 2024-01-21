
# instance_name, external_ip, fqdn
output "test" {
  value = [
    { 
      web=[yandex_compute_instance.platform.network_interface[0].nat_ip_address, 
      yandex_compute_instance.platform.fqdn,
      yandex_compute_instance.platform.name] } ,
    { db = [yandex_compute_instance.platform2.network_interface[0].nat_ip_address, 
      yandex_compute_instance.platform2.fqdn,
      yandex_compute_instance.platform2.name]  }
  ]
}

# terraform output > test.txt