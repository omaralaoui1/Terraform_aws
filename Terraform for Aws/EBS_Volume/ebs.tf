resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = "us-east-1a"
  size              = 40
  type = "gp2"

  tags = {
    Name = "volume1"
  }
}