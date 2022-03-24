# Terraform providers
terraform {
    required_providers  {
        random = {
            source = "hashicorp/random"
            version = "3.1.0"
        }
    }
}

# Input variables
variable "min" {
  type = number
  default = 1
  description = "Min value to random integer"
}

variable "max" {
    type = number
    default = 100
    description = "Max value to random integer"
}

# Instances random provider
resource "random_integer" "rand" {
  min = var.min
  max = var.max
}

locals {
    random_result = random_integer.rand.result
}

output "random_result" {
    value = local.random_result
}