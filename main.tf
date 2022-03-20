resource "random_id" "id" {
  byte_length = 4
}

data "aws_caller_identity" "current" {}

locals {
  identifier = lower("${var.application}-${var.environment}-${random_id.id.hex}")
}
  