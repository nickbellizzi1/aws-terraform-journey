##############################################################################
# LESSON 1: Launch one free-tier EC2 instance
#
# Goal: understand the 4 pieces every Terraform file has, and see Terraform
# actually create something real in your AWS account.
##############################################################################

# --- 1. Tell Terraform which "provider" (cloud) plugin to download ---------
# Every Terraform project starts with this block. It doesn't create
# anything by itself — it just says "I'm going to be talking to AWS,
# go get the AWS plugin."
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" # where to download the plugin from
      version = "~> 5.0"        # "any 5.x version" — pins the major version so
                                 # a future breaking change doesn't surprise you
    }
  }
}

# --- 2. Configure that provider ---------------------------------------------
# This tells the AWS plugin WHERE to create things (which region) and
# implicitly, WHO — it reads your credentials from the same place the AWS
# CLI does (~/.aws/credentials), so if `aws sts get-caller-identity` works
# on your machine, this will too.
provider "aws" {
  region = var.aws_region
}

# --- 3. Look up a value we need, instead of hardcoding it -------------------
# AMI = "Amazon Machine Image" — the OS template an EC2 instance boots from.
# AMI IDs change over time and differ per region, so instead of hardcoding
# something like "ami-0abcdef1234567890" that will go stale, we ask AWS:
# "what's the current Amazon Linux 2023 image?" This is called a DATA SOURCE
# — it reads existing info, it doesn't create anything.
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

# --- 4. The actual resource: the EC2 instance -------------------------------
# This is the only thing in this file that costs money — and at t2.micro,
# it's covered by the AWS free tier (750 hours/month for your first 12
# months). Still: destroy it when you're done experimenting (see README).
resource "aws_instance" "learning_box" {
  ami           = data.aws_ami.amazon_linux.id # from the data source above
  instance_type = var.instance_type            # "t2.micro" — free tier size

  # Tags are just labels. This one makes it easy to find in the AWS console
  # instead of hunting through a list of instance IDs.
  tags = {
    Name = "terraform-lesson-1"
  }
}