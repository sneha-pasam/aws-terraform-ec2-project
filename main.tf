# Define the instance (The Virtual Server)
resource "aws_instance" "web_server" {
  ami           = "ami-07f07a6e1060cd2a8"
  key_name      = "my-terraform-key" # IMPORTANT: Replace with a key pair you own
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  
  # Install Apache Web Server on boot
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install apache2 -y
              sudo systemctl start apache2
              sudo systemctl enable apache2
              echo "<h1>Hello from Terraform Deployed EC2!</h1>" | sudo tee /var/www/html/index.html
              EOF

  tags = {
    Name = "Project2-Terraform-Webserver"
  }
}

# Define the Security Group (The Firewall)
resource "aws_security_group" "web_sg" {
  name        = "web_security_group"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = "vpc-09667f102e3530135" # IMPORTANT: Replace with your VPC ID

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
