resource "aws_key_pair" "terraform_key" {
  key_name = "terraform_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}
resource "aws_instance" "ec2_terraform" {
  ami           = lookup(var.AMIs, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.terraform_key.key_name
  availability_zone = "us-east-1a"
 

  tags = {
    Name= "demoinstance"
  }

}
#Attach EBS with AWS instance
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_volume.id
  instance_id = aws_instance.ec2_terraform.id
}

