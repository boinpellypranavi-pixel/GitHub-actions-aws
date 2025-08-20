provider "aws" {
  region = var.aws_region
}

locals {
  app_name = "analytics-dashboard"
  env      = "staging"
  tags = {
    App = local.app_name
    Env = local.env
  }
}
