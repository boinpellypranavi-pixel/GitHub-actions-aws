resource "aws_security_group" "alb_sg_pranavi" {
  name        = "alb-pranavi"
  description = "Allow HTTPS"
  vpc_id      = aws_vpc.pranavi_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
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
