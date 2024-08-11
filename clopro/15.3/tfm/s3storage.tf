// https://yandex.cloud/ru/docs/storage/operations/buckets/create

# Создание бакета с использованием ключа
resource "yandex_storage_bucket" "stackals-bkt" {
  access_key            = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key            = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket                = var.s3_name
  max_size              = var.s3_size
  default_storage_class = var.s3_class
  anonymous_access_flags {
    read        = true
    list        = true
    config_read = true
  }
  # включаю шифрование для бакета
  # https://yandex.cloud/ru/docs/storage/operations/buckets/encrypt
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-a.id
        sse_algorithm     = "aws:kms"
      }
    }
  }

}

resource "yandex_storage_object" "image" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = var.s3_name
  key        = "image.jpg"
  #   source    = "${file("${path.module}/image.jpg")}"
  #   source = file("./image.jpg")
  source = "/mnt/c/Users/stack/MyProjects/Learning/nl-homeworks/clopro/15.2/tfm/image.jpg"
  acl    = "public-read"
}