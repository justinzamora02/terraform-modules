module "dynamodb_labels" {
  source   = "cloudposse/label/null"
  # Cloud Posse recommends pinning every module to a specific version
  # version = "x.x.x"

  namespace  = "jdb"
  stage      = "testing"
  name       = "tfstate"
  delimiter  = "-"
  attributes = ["db"]
}

resource "aws_dynamodb_table" "table" {
  name           = module.dynamodb_labels.id
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = module.dynamodb_labels.tags
}