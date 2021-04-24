data "aws_region" "current" {}

data "aws_subnet" "master_subnet" {
  id = var.MasterSubnetId
}
