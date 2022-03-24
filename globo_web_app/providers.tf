terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}
##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  #   access_key = var.aws_access_key
  #   secret_key = var.aws_secret_key
  region  = var.aws_region
  profile = "ggtech" # Tomara las credenciales de ~/.aws/credentials
}

## No es necesario configurar el proveedor random es por eso que no añadimos un bloque de configuración 