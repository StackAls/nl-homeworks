resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",

    {
      webservers = yandex_compute_instance.platform
      databases  = yandex_compute_instance.platform-db
      storage    = [yandex_compute_instance.storage]
  })

  filename = "${abspath(path.module)}/hosts.cfg"
}

resource "null_resource" "nginx" {

  depends_on = [yandex_compute_instance.platform]

  provisioner "local-exec" {
    command = "sleep 60"
  }

  provisioner "local-exec" {
    command  = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook --private-key=~/.ssh/nl-ya-ed25519 -i ${abspath(path.module)}/hosts.cfg ${abspath(path.module)}/test.yml"
    on_failure = continue
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
  }
    
  triggers = {
      always_run         = "${timestamp()}"
      playbook_src_hash  = file("${abspath(path.module)}/test.yml")
      # ssh_public_key     = var.public_key
    }

}
