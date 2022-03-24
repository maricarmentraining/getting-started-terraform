# en este archivo definiremos las variables locales de nuestra configuración

resource "random_integer" "rand" {
  min = 100000
  max = 900000
}

locals {
  # Lo primero sera un mapa con las etiquetas comunes
  common_tags = {
    company      = var.company
    project      = "${var.company}-${var.project}"
    billing_code = var.billing_code
  }

  s3_bucket_name = lower("${local.name_prefix}-${random_integer.rand.result}")

  name_prefix = "${var.naming_prefix}-dev"
}