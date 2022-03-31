module "vpc" {
  source = "../.."

  namespace        = "local"
  stage            = "test"
  name             = "min"
  is_highavailable = false
}