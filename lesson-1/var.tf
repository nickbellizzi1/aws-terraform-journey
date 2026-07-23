##############################################################################
# VARIABLES — think of these as the "inputs" to your Terraform file, like
# parameters to a function. Instead of hardcoding "us-east-1" inside main.tf,
# we declare it here so it's easy to find and change in one place.
##############################################################################

variable "aws_region" {
  description = "Which AWS region to create things in"
  type        = string
  default     = "us-east-1" # cheapest / most feature-complete region generally
}

variable "instance_type" {
  description = "EC2 instance size — t2.micro is free-tier eligible"
  type        = string
  default     = "t2.micro"
}