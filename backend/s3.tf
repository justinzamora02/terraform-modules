module "s3_label" {
  source   = "cloudposse/label/null"
  # Cloud Posse recommends pinning every module to a specific version
  # version = "x.x.x"

  namespace  = "jdb"
  stage      = "testing"
  name       = "tfstate"
  delimiter  = "-"
}

resource "aws_s3_bucket" "b" {
  bucket = module.s3_label.id

  tags = module.s3_label.tags
}