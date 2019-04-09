provider "aws" {
  region = "ap-northeast-1"
}

module "rds-mysql-utf8" {
  # source = "git@github.com:ispec-inc/terraform-rds-mysql-utf8.git"
  source = "../../"

  port                 = 3306
  username             = "test_user"
  password             = "remember_test_user"
  db_name              = "test-mysql"
  instance_class       = "db.t2.micro"
  db_subnet_group_name = "default"
  vpc_id               = "${aws_vpc.test_vpc.id}"
}

resource "aws_vpc" "test_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "private_db1" {
  vpc_id            = "${aws_vpc.test_vpc.id}"
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"
}

resource "aws_subnet" "private_db2" {
  vpc_id            = "${aws_vpc.test_vpc.id}"
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-1c"
}

resource "aws_security_group" "db" {
  name        = "mysql_server"
  description = "It is a security group on db of tf_vpc."
  vpc_id      = "${aws_vpc.test_vpc.id}"

  tags {
    Name = "tf_db"
  }
}

resource "aws_security_group_rule" "db" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.db.id}"
}
