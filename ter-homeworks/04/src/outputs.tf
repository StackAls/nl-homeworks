output "userdata" {
  value = "\n${data.template_file.cloudinit.rendered}"
}