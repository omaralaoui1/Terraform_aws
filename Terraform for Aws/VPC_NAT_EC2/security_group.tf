resource "aws_security_group" "sg_allow_ssh" {
  name        = "allow_ssh"
  vpc_id      = aws_vpc.terraform_demo.id

  ingress{
      description      = "SSH from VPC"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  
  egress{
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  tags = {
      Name = "sg_allow_ssh"
  }
  
}