output "servers" {
  value = [
    [for i in yandex_compute_instance.platform : {
        name = i.name
        id = i.id
        fqdn = i.fqdn
    }],
    [for i in yandex_compute_instance.platform-db : {
        name = i.name
        id = i.id
        fqdn = i.fqdn
    }
  ]]
}
