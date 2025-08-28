provider "aws" {
  region = "eu-west-2"
}

# Security group
resource "aws_security_group" "sejal_sg" {
  name        = "sejal-sg"
  description = "Allow SSH and Jenkins access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security group for Application Node
resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  description = "Allow SSH and Tomcat access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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

# Jenkins Master EC2
resource "aws_instance" "jenkins_master" {
  ami           = "ami-0e5f882be1900e43b"
  instance_type = "t2.micro"
  key_name      = "Sejal_newkey"
  security_groups = [aws_security_group.sejal_sg.name]
  tags = {
    Name = "sejal_mastercontroller"
  }
 
}

# Application Node EC2
resource "aws_instance" "app_node" {
  ami           = "ami-0e5f882be1900e43b"
  instance_type = "t2.micro"
  key_name      = "Sejal_newkey"
  security_groups = [aws_security_group.app_sg.name]
  tags = {
    Name = "sejal_managernode"
  }
}
output "Jenkins_master_public_ip" {
  value = aws_instance.jenkins_master.public_ip
}
output "app_node_public_ip" {
  value = aws_instance.app_node.public_ip
  
}