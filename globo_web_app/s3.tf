module "s3_bucket" {
  source = "./modules/s3"

  bucket_name             = local.s3_bucket_name
  elb_service_account_arn = data.aws_elb_service_account.root.arn
  common_tags             = local.common_tags
}

resource "aws_s3_bucket_object" "website_content" {
  for_each = { # for_each itera sobre elementos estructurados
    website = "/website/index.html"
    logo    = "/website/Globo_logo_Vert.png"
  }

  bucket = module.s3_bucket.bucket.id
  key    = each.value # Nos activa las propiedades each.value y each.key
  source = ".${each.value}"

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-s3object-${each.key}"
  })

}

