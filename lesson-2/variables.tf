variable "aws_region" {
  description = "Which AWS region to create things in"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The IP address range for the whole VPC"
  type        = string
  default     = "10.0.0.0/16"
}
resource "aws_internet_gateway" "learning_igw" {
  vpc_id = aws_vpc.learning_vpc.id

  tags = {
    Name = "terraform-lesson-2-igw"
  }
}
variable "public_subnet_cidr" {
  description = "IP range for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "IP range for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone" {
  description = "Which AZ to put both subnets in (single-AZ for this lesson)"
  type        = string
  default     = "us-east-1a"
}