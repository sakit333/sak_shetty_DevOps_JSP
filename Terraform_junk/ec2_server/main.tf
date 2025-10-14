provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}
resource "aws_instance" "app_server" {
  ami           = "ami-02d26659fd82cf299"
  instance_type = "t2.micro"
  key_name      = "darshan_king_110"
  count         = 1
  root_block_device {
    volume_size = 20
    volume_type = "gp2"
  }
  tags = {
    Name = "sak_server"
  }
  security_groups = [aws_security_group.app_sg.name]
  user_data       = file("sample.sh")
}

resource "aws_security_group" "app_sg" {
  tags = {
    Name = "sak_sg"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
output "public_ips" {
  value = [for instance in aws_instance.app_server : instance.public_ip]
}

output "private_ips" {
  value = [for instance in aws_instance.app_server : instance.private_ip]
}