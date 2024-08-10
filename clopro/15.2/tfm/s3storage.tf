// https://yandex.cloud/ru/docs/storage/operations/buckets/create

// Создание сервисного аккаунта
resource "yandex_iam_service_account" "sa" {
  folder_id = var.folder_id
  name      = var.s3_user
}

// Назначение роли сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

// Создание бакета с использованием ключа
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