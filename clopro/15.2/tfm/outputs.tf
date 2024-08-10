# output "vm" {
#   value = [
#     {
#       nat = [yandex_compute_instance.nat.network_interface[0].nat_ip_address,
#         yandex_compute_instance.nat.network_interface[0].ip_address,
#         yandex_compute_instance.nat.fqdn,
#     yandex_compute_instance.nat.name] },
#     { public = [yandex_compute_instance.public.network_interface[0].nat_ip_address,
#       yandex_compute_instance.public.network_interface[0].ip_address,
#       yandex_compute_instance.public.fqdn,
#     yandex_compute_instance.public.name] },
#     { private = [yandex_compute_instance.private.network_interface[0].nat_ip_address,
#       yandex_compute_instance.private.network_interface[0].ip_address,
#       yandex_compute_instance.private.fqdn,
#     yandex_compute_instance.private.name] }
#   ]
# }

# output "external_ip_address" {
#   value = yandex_compute_instance.vm.*.network_interface.0.nat_ip_address
# }

# output "internal_ip_address" {
#   value = yandex_compute_instance.vm.*.network_interface.0.ip_address
# }

# output "fqdn" {
#   value = yandex_compute_instance.vm.*.fqdn
# }

# output "labels" {
#   value = yandex_compute_instance.vm.*.labels
# }

# output "network_interface" {
#   value = yandex_compute_instance.vm.*.network_interface
# }

