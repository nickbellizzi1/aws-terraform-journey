output "vpc_id" {
  value = aws_vpc.learning_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "nat_gateway_public_ip" {
  description = "The Elastic IP the NAT Gateway uses to reach the internet"
  value       = aws_eip.nat.public_ip
}