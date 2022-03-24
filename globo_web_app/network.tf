

##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available" {
  state = "available"
}

##################################################################################
# RESOURCES
##################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "=3.13.0"

  cidr = var.vpc_cidr_block

  azs            = slice(data.aws_availability_zones.available.names, 0, var.vpc_subnet_count)
  public_subnets = [for v in range(var.vpc_subnet_count) : cidrsubnet(var.vpc_cidr_block, 8, v)]

  enable_nat_gateway = false // No lo necesitamos por que no tenemos subredes privadas por lo que no necesitamos una pueta de enlace NAT
  enable_vpn_gateway = false // False por que no estamos usando una puerta de enlace vpn

  # De esta forma asignamos el mapa de variables localesa las tags
  # con merge mezclamos dos mapas u objetos y retornamos uno
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-vpc"
  })
}

# SECURITY GROUPS #
# Nginx security group 
resource "aws_security_group" "nginx_sg" {
  name   = "nginx_sg"
  vpc_id = module.vpc.vpc_id
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-sg"
  })

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    /* cidr_blocks = [var.vpc_cidr_block] */
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "alb_sg" {
  name   = "nginx_alb_sg"
  vpc_id = module.vpc.vpc_id
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-sg"
  })

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
