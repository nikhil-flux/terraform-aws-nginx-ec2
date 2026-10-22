variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "nginx-server"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "vpc_id" {
  description = "VPC ID where resources will be created (e.g. vpc-0abc1234)"
  type        = string

  validation {
    condition     = can(regex("^vpc-[0-9a-f]+$", var.vpc_id))
    error_message = "vpc_id must look like vpc-0abc1234."
  }
}

variable "subnet_id" {
  description = "Public subnet ID for the EC2 instance (e.g. subnet-0abc1234)"
  type        = string

  validation {
    condition     = can(regex("^subnet-[0-9a-f]+$", var.subnet_id))
    error_message = "subnet_id must look like subnet-0abc1234."
  }
}

variable "ssh_cidr_blocks" {
  description = "CIDR blocks allowed for SSH access (use your public IP, e.g. 203.0.113.25/32)"
  type        = list(string)

  validation {
    condition     = !contains(var.ssh_cidr_blocks, "0.0.0.0/0")
    error_message = "Do not open SSH to the whole internet. Use your own IP as x.x.x.x/32."
  }
}
