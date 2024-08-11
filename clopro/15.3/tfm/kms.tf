# ключ шифрования для бакета
resource "yandex_kms_symmetric_key" "key-a" {
  name              = "key-a"
  description       = "key for backet"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" // 1 год
}