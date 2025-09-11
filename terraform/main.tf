provider "aws" {
  region = "us-east-1"
}

# Public S3 bucket with no encryption
resource "aws_s3_bucket" "bad_bucket" {
  bucket = "my-insecure-bucket"
  acl    = "public-read"   # ❌ Public bucket
}

# Security group open to the world
resource "aws_security_group" "bad_sg" {
  name        = "open-sg"
  description = "Open to the world"
  vpc_id      = "vpc-123456"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # ❌ SSH open to all
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance with plaintext credentials in user_data
resource "aws_instance" "bad_ec2" {
  ami           = "ami-123456"
  instance_type = "t2.micro"

  user_data = <<EOF
#!/bin/bash
echo "DB_PASSWORD=supersecret" >> /etc/environment   # ❌ Hardcoded secrets
EOF
}
