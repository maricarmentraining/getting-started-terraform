##################################################################################
# DATA
##################################################################################

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "nginxs" {
  count                  = var.instance_nginx_count
  ami                    = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type          = var.ec2_instance_type
  subnet_id              = module.vpc.public_subnets[(count.index % var.vpc_subnet_count)] # Muy interesante el uso del operador modulo para que no afecte que haya mas instancias que subredes o mas subredes que instancias
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  iam_instance_profile   = module.s3_bucket.instance_profile.name
  depends_on             = [module.s3_bucket]

  user_data = templatefile("${path.module}/startup_script.tftpl", {
    s3_bucket_name = module.s3_bucket.bucket.id
  })

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-instance-${count.index}"
  })

}