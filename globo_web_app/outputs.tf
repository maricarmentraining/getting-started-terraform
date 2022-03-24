# Aqui definiremos todas las salidas de nuestro codigo
output "aws_instance_public_dns" {
  value = aws_lb.nginx.dns_name
}