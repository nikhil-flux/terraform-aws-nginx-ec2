Terraform AWS Nginx EC2
Provision a fully working Nginx web server on AWS EC2 using Terraform — from zero to a live public IP in under 2 minutes.
This project spins up:
	•	A security group allowing HTTP (80), HTTPS (443), and SSH (22)
	•	An EC2 instance running the latest Ubuntu 22.04 LTS
	•	Nginx, auto-installed and started via a user data script
	•	A custom homepage served on first boot
    

Prerequisites
    •	Terraform >= 1.0
	•	AWS CLI configured with valid credentials (aws configure)
	•	An AWS account with a default VPC and subnet
    •	VS Code (recommended) with the HashiCorp Terraform extension

Project Structure
    .

    ├── main.tf                     # Core infrastructure (security group, EC2, AMI lookup)
    ├── variables.tf                # Input variable definitions
    ├── terraform.tfvars.example    # Template for your own values (copy to terraform.tfvars)
    ├── user_data.sh                # EC2 startup script — installs and configures Nginx
    ├── index.html                  # Homepage served by Nginx
    └── .gitignore                  # Excludes state files and secrets from version 
    control

Setup

	1.	Clone the repository
        git clone https://github.com/YOUR_USERNAME/terraform-aws-nginx-ec2.git
        cd terraform-aws-nginx-ec2
    2.	Copy the example variables file and fill in your own values
        cp terraform.tfvars.example terraform.tfvars
    3.	Initialize Terraform
        terraform init
    4.	Preview the plan
        terraform plan
    5.	Apply
        terraform apply
        # Type yes when prompted.
    6.	Visit your server
        Terraform will output a public IP — open http://<public-ip> in your browser.
    7.  Cleaning up
        To avoid ongoing AWS charges, destroy the resources when you’re done.
        terraform destroy 

Variables
    |Name             |Description                  |Default        |
|-----------------|-----------------------------|---------------|
|`aws_region`     |AWS region to deploy into    |`us-east-1`    |
|`instance_name`  |Name tag for the EC2 instance|`nginx-server` |
|`instance_type`  |EC2 instance type            |`t3.micro`     |
|`vpc_id`         |VPC ID to deploy into        |*(required)*   |
|`subnet_id`      |Subnet ID to deploy into     |*(required)*   |
|`ssh_cidr_blocks`|CIDR blocks allowed to SSH   |`["0.0.0.0/0"]`|

Notes
	•	The AMI is looked up dynamically (latest Ubuntu 22.04), so it stays current without manual updates.
	
    •	ssh_cidr_blocks defaults to open access (0.0.0.0/0) for convenience — restrict this to your own IP in production.
	
    •	State is stored locally by default (terraform.tfstate, gitignored). For team use, configure a remote backend such as S3.

