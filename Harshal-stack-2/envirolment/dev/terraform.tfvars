env_name             = "dev"
vpc_cidr             = "10.0.0.0/16"
public_subnet_count  = 3
private_subnet_count = 3
rds_sg_ingress_rules = {
  mysql = {
    description = "App MYSQL DB Connection"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}
rds_db_username       = "admin"
rds_db_parameter_name = "rds_db_password"
instance_type         = "t2.medium"
jar_file_name         = "datastore-0.0.7.jar"
desired_capacity      = 1
min_size              = 1
max_size              = 1
slack_web_hook_url = "replace me"
fe_instance_type      = "t2.medium"
origin_id                        = "fe-web"
default_behavior_allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
default_behavior_cached_methods  = ["GET", "HEAD"]
default_behavior_forwarded_values_header = ["Origin", "Sec-WebSocket-Key", "Sec-WebSocket-Version", "Host", "Sec-WebSocket-Extensions"]
