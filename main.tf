module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "1.22.0"

  identifier         = "${var.db_name}-db"
  allocated_storage  = 5
  backup_window      = "03:00-06:00"
  engine             = "mysql"
  engine_version     = "5.7"
  maintenance_window = "Mon:00:00-Mon:03:00"

  instance_class          = "${var.instance_class}"
  publicly_accessible     = true
  backup_retention_period = 1
  skip_final_snapshot     = true
  major_engine_version    = "5.7"

  vpc_security_group_ids = ["${aws_security_group.db.id}"]
  subnet_ids             = ["${var.subnet_ids}"]

  name     = "${var.db_name}"
  password = "${var.password}"
  username = "${var.username}"
  port     = "${var.port}"

  family = "mysql5.7"

  parameters = [
    {
      name  = "time_zone"
      value = "Asia/Tokyo"
    },
    {
      name         = "character_set_client"
      value        = "utf8mb4"
      apply_method = "immediate"
    },
    {
      name         = "character_set_connection"
      value        = "utf8mb4"
      apply_method = "immediate"
    },
    {
      name         = "character_set_database"
      value        = "utf8mb4"
      apply_method = "immediate"
    },
    {
      name         = "character_set_filesystem"
      value        = "utf8mb4"
      apply_method = "immediate"
    },
    {
      name         = "character_set_results"
      value        = "utf8mb4"
      apply_method = "immediate"
    },
    {
      name         = "character_set_server"
      value        = "utf8mb4"
      apply_method = "immediate"
    },
    {
      name         = "collation_connection"
      value        = "utf8mb4_general_ci"
      apply_method = "immediate"
    },
    {
      name         = "collation_server"
      value        = "utf8mb4_general_ci"
      apply_method = "immediate"
    },
  ]
}

resource "aws_security_group" "db" {
  name        = "db_server"
  description = "It is a security group on db of tf_vpc."
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "db" {
  type              = "ingress"
  from_port         = "${var.port}"
  to_port           = "${var.port}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.db.id}"
}
