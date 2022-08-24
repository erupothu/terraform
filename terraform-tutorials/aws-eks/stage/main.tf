provider "aws" {
  region = "ap-south-1"
}

locals {
  create_vpc = "${var.vpc_id == "" ? 1 : 0}"
}

data "aws_vpc" "selected" {
  count = "${1 - local.create_vpc}"

  id = "${var.vpc_id}"
}

resource "aws_vpc" "this" {
  count = "${1 - local.create_vpc}"

  id = "${var.vpc_id}"
}
