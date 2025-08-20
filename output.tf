output "vpc_id" {
  value = aws_vpc.main.id
}
output "subnet_id" {
  value = [for s in aws_subnet.public : s.id]
}
