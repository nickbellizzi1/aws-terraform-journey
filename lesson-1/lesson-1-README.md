# Lesson 1: One EC2 instance

**Goal:** understand the core Terraform workflow (`init` -> `plan` -> `apply` -> `destroy`) by launching one free-tier EC2 instance and watching it appear in the AWS console.

## What's in here

- `main.tf` - the provider config, a data lookup for the AMI, and the EC2 instance itself (every line has a comment explaining what it does and why)
- `variables.tf` - the two inputs (region, instance size)
- `outputs.tf` - prints the instance ID and public IP after apply

## How to run it

### 1. Install Terraform and configure AWS CLI credentials

Run `aws configure` and enter your access key, secret key, and region.

### 2. Run the Terraform workflow

Run these three commands in order:

    terraform init
    terraform plan
    terraform apply

### 3. Check it out

Go to AWS Console -> EC2 -> Instances to see it running.

### 4. Tear it down

Run:

    terraform destroy

This is the step that stops billing - always run it when you're done for the session.

## What confused me going in

- Assumed my AWS CLI's default region (`us-west-1`) would control where Terraform created things. It doesn't - the region is set inside the Terraform variable (`variables.tf`), completely independent of your personal CLI config. Found the instance sitting in `us-east-1` instead, because that's what the `.tf` file said, not my CLI default.

## What clicked

- The `.tf` files are the description of what you want; the commands (`init`/`plan`/`apply`/`destroy`) are separate actions that read those files and act on them. You're not typing steps in order - you're writing an end state and letting Terraform figure out how to get there.

## Next lesson

`02-vpc-networking` - instead of using the default VPC, build a custom one with public/private subnets, so the EC2 instance lives somewhere I actually designed instead of AWS's out-of-the-box network.
