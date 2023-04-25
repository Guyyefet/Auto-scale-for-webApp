# resource "aws_db_instance" "test-db" {
#   identifier             = "test-db"
#   name                   = "test-db"
#   instance_class         = "db.t2.micro"
#   allocated_storage      = 20
#   engine                 = "postgres"
#   engine_version         = "12.5"
#   skip_final_snapshot    = true
#   publicly_accessible    = true
#   vpc_security_group_ids = [aws_security_group.db_sg.id]
#   username               = "test-db"
#   password               = ""
# }