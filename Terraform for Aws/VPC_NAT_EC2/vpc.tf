#Create AWS VPC
resource "aws_vpc" "terraform_demo" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"

  tags = {
    Name = "terraform_demo"
  }
}
#  Public Subnets in custom VPC
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.terraform_demo.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public_subnet"
  }
}
#  Private Subnets in custom VPC
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.terraform_demo.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "private_subnet"
  }
}
# Custom Internet Gateway
resource "aws_internet_gateway" "gw_terraform" {
  vpc_id = aws_vpc.terraform_demo.id

  tags = {
    Name = "gw_terraform"
  }
}

# Route Table
resource "aws_route_table" "terraform_table_public" {
  vpc_id = aws_vpc.terraform_demo.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.gw_terraform.id
    }
  

  tags = {
    Name = "terraform_table_public"
  }
}
# Association Route Table with Subnet
resource "aws_route_table_association" "association_terraform_demo_public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.terraform_table_public.id
}
