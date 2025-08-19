resource "aws_vpc" "pranavi_vpc" {
  cidr_block = var.vpc_cidr
  tags = { Name = "staging-vpc" }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.21.21.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ca-central-1a"
}
