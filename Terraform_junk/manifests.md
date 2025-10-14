### Task 1
```hcl
provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}
resource "aws_instance" "example_1" {
  ami           = "ami-03b8adbf322415fd0"
  instance_type = "t2.micro"
  key_name      = "astroids_203"
}
```
---
### Task 2
```hcl
provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}
resource "aws_instance" "example_1" {
  ami           = "ami-03b8adbf322415fd0"
  instance_type = "t2.micro"
  key_name      = "astroids_203"
  tags = {
    Name = "ExampleInstance"
  }
}
```
---
### Task 3
```hcl
provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}
resource "aws_instance" "example_1" {
  ami           = "ami-03b8adbf322415fd0"
  instance_type = "t2.micro"
  key_name      = "astroids_203"
  count         = "3"
  tags = {
    Name = "production"
  }
}
```
---
### Task 4
```hcl
provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}
resource "aws_instance" "example_1" {
  ami           = "ami-03b8adbf322415fd0"
  instance_type = "t2.micro"
  key_name      = "astroids_203"
  tags = {
    Name = "production"
  }
}
output "public_ip" {
  value = aws_instance.example_1.public_ip
}
```
---
### Task 5
```hcl
provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}
# Variable block for AMI ID
variable "ami_id" {
  description = "for astroids"
  type        = string
  default     = "ami-03b8adbf322415fd0"
}
resource "aws_instance" "example_1" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = "astroids_203"
  tags = {
    Name = "production"
  }
}
output "public_ip" {
  value = aws_instance.example_1.public_ip
}
```
### Task 6
```hcl
provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}
resource "aws_instance" "example_1" {
  ami           = "ami-03b8adbf322415fd0"
  instance_type = "t2.micro"
  key_name      = "astroids_203"
  count         = "1"
  tags = {
    Name = "production"
  }
}
output "public_ip" {
  value = aws_instance.example_1[0].public_ip
}
output "private_ip" {
  value = aws_instance.example_1[0].private_ip
}
```
### Task 7
```hcl
provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}
resource "aws_security_group" "example_sg" {
  tags = {
    Name = "securityexample"
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
```
### Task 8
```hcl
provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}
resource "aws_instance" "example_1" {
  ami           = "ami-03b8adbf322415fd0"
  instance_type = "t2.micro"
  key_name      = "astroids_203"
  tags = {
    Name = "production"
  }
  security_groups = [aws_security_group.example_sg.name]
  # Attach a 30GB EBS volume as root storage
  root_block_device {
    volume_size = 20 
    volume_type = "gp3"  
    delete_on_termination = true  
  }
}
resource "aws_security_group" "example_sg" {
  tags = {
    Name = "securityexample"
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
output "public_ip" {
  value = aws_instance.example_1.public_ip
}
output "private_ip" {
  value = aws_instance.example_1.private_ip
}
```
### Task 9
```hcl
provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}
resource "aws_security_group" "example_sg" {
  tags = {
    Name = "securityexample"
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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
```
### Task 10
```hcl
provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}
resource "aws_instance" "example_1" {
  ami           = "ami-03b8adbf322415fd0"
  instance_type = "t2.micro"
  key_name      = "astroids_203"
  tags = {
    Name = "production"
  }
  security_groups = [aws_security_group.example_sg.name]
  user_data       = file("sample.sh")
}
resource "aws_security_group" "example_sg" {
  tags = {
    Name = "securityexample"
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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
output "public_ip" {
  value = aws_instance.example_1.public_ip
}
```
### 11
```hcl
provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}
resource "aws_s3_bucket" "astroidsdevops" {
  bucket = "astroidsdevops"
  
  versioning {
    enabled = true  
  }

  acl = "private"  
  tags = {
    Name = "astroidsdevops"
  }
}

resource "aws_s3_bucket_public_access_block" "astroidsdevops_access_block" {
  bucket = aws_s3_bucket.astroidsdevops.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "bucket_name" {
  value = aws_s3_bucket.astroidsdevops.bucket
}

output "bucket_path" {
  value = "s3://${aws_s3_bucket.astroidsdevops.bucket}"
}
```
### 12
```hcl
provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}
resource "aws_vpc" "flipkart" {
  cidr_block           = "10.0.0.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "flipkart-vpc"
  }
}

output "vpc_id" {
  value = aws_vpc.flipkart.id
}

output "vpc_cidr_block" {
  value = aws_vpc.flipkart.cidr_block
}
```
### 13
```hcl
provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}

resource "aws_vpc" "flipkart" {
  cidr_block           = "10.0.0.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "flipkart-vpc"
  }
}

resource "aws_subnet" "flipkart_public_subnet" {
  vpc_id                  = aws_vpc.flipkart.id
  cidr_block              = "10.0.0.0/25"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "flipkart_public-subnet"
  }
}

output "vpc_id" {
  value = aws_vpc.flipkart.id
}

output "vpc_cidr_block" {
  value = aws_vpc.flipkart.cidr_block
}

output "subnet_id" {
  value = aws_subnet.flipkart_public_subnet.id
}

output "subnet_cidr_block" {
  value = aws_subnet.flipkart_public_subnet.cidr_block
}
```
### 14
```hcl
provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}
resource "aws_vpc" "flipkart" {
  cidr_block           = "10.0.0.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "flipkart-vpc"
  }
}
resource "aws_internet_gateway" "flipkart_gateway" {
  vpc_id = aws_vpc.flipkart.id
  tags = {
    Name = "flipkart-internet-gateway"
  }
}
output "vpc_id" {
  value = aws_vpc.flipkart.id
}

output "vpc_cidr_block" {
  value = aws_vpc.flipkart.cidr_block
}
output "internet_gateway_id" {
  value = aws_internet_gateway.flipkart_gateway.id
}

```

### 15

- `envs/dev.tfvars`
```hcl
region             = "ap-south-1"
ami_id             = "ami-00bb6a80f01f03502"
instance_type      = "t2.micro"
key_name           = "sak_admin"
```
- `variables.tf`
```hcl
variable "region" {
  description = "AWS region for the deployment"
  type        = string
}
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}
```
- `main.tf`
```hcl
provider "aws" {
  region     = var.region
  access_key = ""
  secret_key = ""
}
resource "aws_instance" "example_1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name = "production"
  }
  # Attach a 20GB EBS volume as root storage
  root_block_device {
    volume_size = 20 
    volume_type = "gp3"  
    delete_on_termination = true  
  }
}
output "public_ip" {
  value = aws_instance.example_1.public_ip
}
```
- **to apply**: `terraform apply -var-file="envs/dev.tfvars" --auto-approve`
- **to apply**: `terraform destroy -var-file="envs/dev.tfvars" --auto-approve`

### 15

- `main.tf`
```hcl
provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}
resource "aws_instance" "example_1" {
  ami           = "ami-03b8adbf322415fd0"
  instance_type = "t2.micro"
  key_name      = "astroids_203"
  count         = "3"
  tags = {
    Name = "production"
  }
}
output "public_ips" {
  value = [for instance in aws_instance.example_1 : instance.public_ip]
}
```
### 16 **Create VPC, SUBNET, IGW, SG, EC2_INSTANCE**
```hcl
provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}

# Create a VPC
resource "aws_vpc" "sak_vpc" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "devops_vpc"
  }
}

# Create a subnet in the VPC
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.sak_vpc.id
  cidr_block        = "10.0.0.0/25"
  availability_zone = "ap-south-1a" 
  tags = {
    Name = "public_subnet"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "sak_igw" {
  vpc_id = aws_vpc.sak_vpc.id
  tags = {
    Name = "devops_igw"
  }
}

# Create a route table
resource "aws_route_table" "sak_route_table" {
  vpc_id = aws_vpc.sak_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sak_igw.id
  }

  tags = {
    Name = "devops_route_table"
  }
}

# Associate the route table with the subnet
resource "aws_route_table_association" "sak_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.sak_route_table.id
}

# Create a security group allowing all traffic
resource "aws_security_group" "sak_sg" {
  vpc_id = aws_vpc.sak_vpc.id

  # Allow all inbound traffic
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow ssh inbound traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  tags = {
    Name = "devops_sg"
  }
}

# Create an EC2 instance in the VPC and subnet
resource "aws_instance" "example" {
  ami           = "ami-03edbe403ec8522ed"
  instance_type = "t2.micro"
  key_name      = "rrnagar_203"
  count         = 1
  vpc_security_group_ids = [aws_security_group.sak_sg.id]
  subnet_id     = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  tags = {
    Name = "app_server"
  }
  user_data = file("httpd.sh")
}

output "public_ip" {
  value = aws_instance.example[0].public_ip
}

output "private_ip" {
  value = aws_instance.example[0].private_ip
}

output "public_dns" {
  value = aws_instance.example[0].public_dns
}

output "private_dns" {
  value = aws_instance.example[0].private_dns
}
```
- `httpd.sh` for userdata
```bash
#!/bin/bash

yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
```