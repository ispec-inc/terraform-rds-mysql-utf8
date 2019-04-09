variable "port" {
  description = "publish port"
  default     = 3306
}

variable "username" {
  description = "username"
}

variable "password" {
  description = "user password"
}

variable "db_name" {
  description = "The database name"
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  default     = "db.t2.micro"
}

variable "db_subnet_group_name" {
  default = "default"
}

variable "vpc_id" {
  description = "VPCID to which the RDS belogs"
}
