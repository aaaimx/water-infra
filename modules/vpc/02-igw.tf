# IGW
resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = {
    "Name" = "vpc-aaaimx-igw"  
  }

  depends_on = [aws_vpc.main]

}