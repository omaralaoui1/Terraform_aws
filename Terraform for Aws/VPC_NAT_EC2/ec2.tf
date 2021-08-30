resource "aws_key_pair" "terraform_key" {
  key_name = "terraform_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}
resource "aws_instance" "ec2_terraform" {
  ami           = lookup(var.AMIs, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.terraform_key.key_name

  vpc_security_group_ids = [aws_security_group.sg_allow_ssh.id]
  subnet_id = aws_subnet.public_subnet.id


  tags = {
    Name= "demoinstance"
  }

}

resource "aws_instance" "ec2_terraform_private" {
  ami           = lookup(var.AMIs, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.terraform_key.key_name
  
  vpc_security_group_ids = [aws_security_group.sg_allow_ssh.id]
  subnet_id = aws_subnet.private_subnet.id


  tags = {
    Name= "demoinstance_private"
  }

}




