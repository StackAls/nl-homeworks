variable "s3_size" {
  type    = number
  default = 1073741824
}

variable "s3_name" {
  type    = string
  default = "stackals-bkt"
}

variable "s3_class" {
  type    = string
  default = "STANDARD"
}

# data "http" "image" {
#   url = "https://img.freepik.com/free-photo/ethereal-environment-with-cloth_23-2151113635.jpg?t=st=1723212988~exp=1723216588~hmac=6716da114ceadba8a12b5d19853f8d5bf8420ceda76eb4233a353c7f7caf9077&w=1380"
# }
