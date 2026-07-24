# Lesson 2: Custom VPC with public/private subnets

**Goal:** move off AWS's auto-generated default VPC and build a custom network from scratch - one public subnet, one private subnet, an Internet Gateway, a NAT Gateway, and the route tables that actually make "public" vs "private" real.

## What's in here

- `main.tf` - VPC, Internet Gateway, both subnets, both route tables + associations, Elastic IP, NAT Gateway
- `variables.tf` - region, VPC CIDR, subnet CIDRs, availability zone
- `outputs.tf` - VPC ID, both subnet IDs, NAT Gateway's public IP

## How to run it

### 1. Configure AWS CLI credentials

Run `aws configure` with the account/keys you want to use, and confirm with:

    aws sts get-caller-identity

### 2. Run the Terraform workflow

    terraform init
    terraform plan
    terraform apply

### 3. Check it out

AWS Console -> VPC dashboard. Look at:
- The VPC and its two subnets
- The public route table and the private route table, and compare their routes

### 4. Tear it down

    terraform destroy

The NAT Gateway is the one piece here with a real, non-free-tier cost (~$0.045/hour + data processing) - don't leave it running.

## What confused me going in

- Terraform's `init` step stalled partway through downloading the AWS provider plugin while the project lived inside a OneDrive-synced folder. Moved the whole repo to `C:\dev` instead and it ran cleanly - a good reminder that dev tooling and cloud-sync folders don't mix well.
- Wasn't sure whether reusing an AWS account that already had leftover resources from AWS SAA study labs would cause conflicts with a new Terraform project. It doesn't - Terraform only tracks what's in its own state file, completely separate from anything else in the account. The one real thing to watch for is AWS's default 5-VPC-per-region limit if an account has a lot of old VPCs sitting around.

## What clicked

- Resource references drive automatic build ordering. I never told Terraform to create the NAT Gateway after the Elastic IP and public subnet - it inferred that purely from `allocation_id = aws_eip.nat.id` and `subnet_id = aws_subnet.public.id` in the code, and the `apply` output built everything in the correct dependency order without me specifying it.
- `depends_on` exists for the cases a reference can't cover. The NAT Gateway genuinely needs the Internet Gateway to exist first, but nothing in its arguments actually references the IGW - so there was no natural reference for Terraform to infer that ordering from. `depends_on` is the manual override for exactly that gap.

## Next lesson

`lesson-3` - add a load balancer and autoscaling group in front of an application tier living in the private subnet, so traffic has to flow through the public tier to reach it.
