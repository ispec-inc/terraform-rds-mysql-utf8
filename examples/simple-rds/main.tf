provider "aws" {
  region = "ap-northeast-1"
}

module "rds-mysql-utf8" {
  # source = "git@github.com:ispec-inc/terraform-rds-mysql-utf8.git"
  source = "../../"

  port           = 3306
  username       = "test_user"
  password       = "remember_test_user"
  db_name        = "test"
  instance_class = "db.t2.micro"

  vpc_id = "${aws_vpc.test_vpc.id}"

  subnet_ids = ["${aws_subnet.public_subnet_1a.id}", "${aws_subnet.public_subnet_1b.id}"]
}

resource "aws_vpc" "test_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.test_vpc.id}"
}

resource "aws_route_table" "route_igw" {
  vpc_id = "${aws_vpc.test_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
}

# Public Subnet on us-east-1a
resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = "${aws_vpc.test_vpc.id}"
  cidr_block              = "10.0.0.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1a"
}

# Public Subnet on us-east-1b
resource "aws_subnet" "public_subnet_1b" {
  vpc_id                  = "${aws_vpc.test_vpc.id}"
  cidr_block              = "10.0.16.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1c"
}

# Associate subnet public_subnet_us_east_1a to public route table
resource "aws_route_table_association" "public_subnet_1a_association" {
  subnet_id      = "${aws_subnet.public_subnet_1a.id}"
  route_table_id = "${aws_route_table.route_igw.id}"
}

# Associate subnet public_subnet_us_east_1b to public route table
resource "aws_route_table_association" "public_subnet_1b_association" {
  subnet_id      = "${aws_subnet.public_subnet_1b.id}"
  route_table_id = "${aws_route_table.route_igw.id}"
}
