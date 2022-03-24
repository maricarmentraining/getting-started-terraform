# Terraform junta todos los archivos de configuracion, es por eso que podemos utilizar varios sin problema
# Lo primero será deshacernos de los valores de: secret_key y access_key 

# variable "aws_access_key" {
#     type = string
#     description = "AWS Access Key"
#     sensitive = true 
# }

# variable "aws_secret_key" {
#     type = string
#     description = "AWS Secret Key"
#     sensitive = true
# }

variable "naming_prefix" {
  type        = string
  description = "Name prefix for all resources"
  default     = "globoweb"
}

variable "aws_region" {
  type        = string
  description = "AWS region to use for resources"
  default     = "us-west-2"
}

variable "vpc_cidr_block" {
  type        = string
  description = "AWS VPC CIDR Block to use in vpc"
  default     = "10.0.0.0/16"
}

variable "vpc_enable_hostnames" {
  type        = bool
  description = "Has vpc enable dns hostnames?"
  default     = true
}

variable "subnets_cidr_block" {
  type        = list(string)
  description = "AWS CIDR Block to use in SUBNET"
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "subnet_map_public_ip_on_launch" {
  type        = bool
  description = "Map public ip on launch instances on Subnet?"
  default     = true
}

variable "route_table_cidr_block" {
  type        = string
  description = "CIDR from route table to connect to internet gateway"
  default     = "0.0.0.0/0"
}

variable "ec2_instance_type" {
  type        = string
  description = "Type of instance to ec2 Instance"
  default     = "t3.micro"
}

variable "company" {
  type        = string
  description = "Instance tag: company"
  default     = "Globalmantics"
}

variable "project" {
  type        = string
  description = "Instace tag: project"
}

variable "billing_code" {
  type        = string
  description = "Instance tag: billing_code "
}

variable "vpc_subnet_count" {
  type        = number
  default     = 2
  description = "Number of subnets to create"
}

variable "instance_nginx_count" {
  type        = number
  default     = 2
  description = "Number of instances to create"
}