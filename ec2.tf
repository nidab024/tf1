
/*
resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu 20.04 LTS
  instance_type = "t2.micro" # Typo here ("micro" is misspelled)
}
# Data source to get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Security group for the EC2 instance
resource "aws_security_group" "ec2_sg" {
  name_prefix = "ec2-private-sg-"
  vpc_id      = "vpc-06a737b57643a9df9"

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH from within VPC (optional)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Adjust CIDR as needed for your VPC
  }

  tags = {
    Name = "ec2-private-security-group"
  }
}

# IAM role for Systems Manager Session Manager
resource "aws_iam_role" "ec2_ssm_role" {
  name = "EC2-SSM-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "EC2-SSM-Role"
  }
}

# Attach the AWS managed policy for Session Manager
resource "aws_iam_role_policy_attachment" "ec2_ssm_policy" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Create instance profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-ssm-profile"
  role = aws_iam_role.ec2_ssm_role.name

  tags = {
    Name = "EC2-SSM-Profile"
  }
}

# EC2 Instance
resource "aws_instance" "linux_instance" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.nano"
  subnet_id     = "subnet-07305b33c769bf723"
  
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  
  # Optional: Add a key pair if you want SSH access
  # key_name = "your-key-pair-name"
  
  # Optional: User data script
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y htop
  EOF

  tags = {
    Name = "linux-t2nano-private"
    Type = "Private Instance"
  }

  # Ensure instance is created in private subnet (no public IP)
  associate_public_ip_address = false
}

# Output the instance details
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.linux_instance.id
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.linux_instance.private_ip
}

output "instance_private_dns" {
  description = "Private DNS name of the EC2 instance"
  value       = aws_instance.linux_instance.private_dns
}
*/
resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu 20.04 LTS
<<<<<<< HEAD
  instance_type = "t2.medium" # second local
}

# add line for git rebase check
=======

  

  instance_type = "t2.nano" # Typo here ("micro" is misspelled)

}
>>>>>>> origin/second
