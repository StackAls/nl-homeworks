output "network_id_dev" {
  value = yandex_vpc_network.develop.*.id
}

output "subnet_id_dev" {
  value = [for v in yandex_vpc_subnet.develop.*: v.id]
}

output "network_id_prod" {
  value = yandex_vpc_network.prod.*.id
}

output "subnet_id_prod" {
  value = [for v in yandex_vpc_subnet.prod.*: v.id]
}
