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
  description = "Specifies whether Performance Insights are enabled."
  type        = bool
  default     = false
}

variable "performance_insights_retention_period" {
  description = "The amount of time in days to retain Performance Insights data."
  type        = number
  default     = 7
}

variable "replicate_source_db" {
  description = "Specifies that this resource is a Replicate database"
  type        = string
  default     = ""
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}
variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted."
  type        = bool
  default     = true
}
