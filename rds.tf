resource "aws_db_parameter_group" "blue_green_parameter_group" {
    name = "stage-parameter-group-rds"
    family = "mysql8.0"
    parameter {
      name = "read_only"
      value = "0"
    }
}

resource "aws_db_instance" "rds_Instance" {
  db_name                = "test_rds_db"
  allocated_storage      = 10
  max_allocated_storage  = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = "!Andrey1989"
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  blue_green_update {
    enabled = true
  }

}
output "name" {
  value = aws_db_instance.rds_Instance.blue_green_update
}


# resource "null_resource" "blue_green_update" {
#   provisioner "remote-exec" {
#     command = "aws rds create-blue-green-deployment \
#     --blue-green-deployment-name my-blue-green-deployment \
#     --source arn:aws:rds:us-east-2:123456789012:db:mydb1 \
#     --target-engine-version 8.0.31 \
#     --target-db-parameter-group-name mydbparametergroup"
#   }
# }


