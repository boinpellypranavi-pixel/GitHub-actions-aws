resource "aws_ecr_repository" "backend" {
  name                 = "${local.app_name}-backend"
  image_tag_mutability = "MUTABLE"
}
resource "aws_ecr_repository" "frontend" {
  name                 = "${local.app_name}-frontend"
  image_tag_mutability = "MUTABLE"
}
