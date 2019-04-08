provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_vpc" "test_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "test_vpc"
  }
}

module "rds-mysql-utf8" {
  source = "git@github.com:ispec-inc/terraform-rds-mysql-utf8.git"

  port = 3306
  username = "test-user"
  password = "remember_test_user"
  db_name = "simple_rds_mysql_utf8"
  instance_class = "db.t2.micro"
  vpc_id = "${aws_vpc.test_vpc.id}"
}