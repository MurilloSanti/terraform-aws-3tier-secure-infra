# ---------------------------
# Buscar AMI Amazon Linux 2023
# ---------------------------

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

# ---------------------------
# EC2 Backend (Private Subnet)
# ---------------------------

resource "aws_instance" "backend" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private_app_a.id
  vpc_security_group_ids = [aws_security_group.app.id]

  user_data = <<-EOF
              #!/bin/bash
              dnf install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from Terraform Backend</h1>" > /var/www/html/index.html
              EOF

  tags = merge(local.common_tags, {
    Name = "dev-backend-ec2"
  })
}

