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

variable "vpc_id" {
  description = "VPCID to which the RDS belogs"
}

variable "subnet_ids" {
  type = list(string)
}

variable "performance_insights_enabled" {
  type    = bool
  default = false
}

variable "performance_insights_retention_period" {
  type    = number
  default = 7
}

variable "replicate_source_db" {
  type    = string
  default = ""
}

variable "publicly_accessible" {
  type    = bool
  default = false
}
