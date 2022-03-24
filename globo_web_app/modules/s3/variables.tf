# Bucket name
variable "bucket_name" {
  type        = string
  description = "Name to s3 bucket"
}

# ELB service account arn
variable "elb_service_account_arn" {
  type        = string
  description = "ARN of ELB service account"
}

# Common tags
variable "common_tags" {
  type        = map(string)
  description = "Map of tag to be applied to all resources"
  default     = {}
}