provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-sspcloudpro"
    key    = "root/terraform.tfstate"
    region = "ap-south-1"
    acl    = "bucket-owner-full-control"
  }
}

