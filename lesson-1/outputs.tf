##############################################################################
# OUTPUTS — after `terraform apply`, Terraform normally just says "Apply
# complete!" and tells you nothing else. Outputs are how you ask it to print
# specific values you'll actually want — here, the instance's ID and IP.
##############################################################################

output "instance_id" {
  value = aws_instance.learning_box.id
}

output "instance_public_ip" {
  description = "You can see this instance running at this IP in the EC2 console"
  value       = aws_instance.learning_box.public_ip
}