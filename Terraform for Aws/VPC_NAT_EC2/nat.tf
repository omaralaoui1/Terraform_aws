# Define External IP
resource "aws_eip" "terraform_ip" {
  vpc = true
}


#Create Nat Gateway
resource "aws_nat_gateway" "terra_nat" {
  allocation_id = aws_eip.terraform_ip.id
  subnet_id     = aws_subnet.public_subnet.id
  depends_on = [aws_internet_gateway.gw_terraform]
  tags = {
    Name = "gw NAT"
  } 
}

resource "aws_route_table" "terraform_table_private" {
  vpc_id = aws_vpc.terraform_demo.id

  route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.terra_nat.id
    }
  

  tags = {
    Name = "terraform_table_private"
  }
}


resource "aws_route_table_association" "association_terraform_demo_private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.terraform_table_private.id
}