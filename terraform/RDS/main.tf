resource "aws_db_instance" "db" {
  allocated_storage    = 20
  max_allocated_storage = 1000
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "db"
  username             = "root"
  password             = "Password1234!"
  port = 3306
  parameter_group_name = "default.mysql5.7"
  vpc_security_group_ids = [aws_security_group.allow_3306.id]
  db_subnet_group_name = aws_db_subnet_group.private.id
  publicly_accessible = true
}

resource "aws_db_instance" "test-db" {
  allocated_storage    = 20
  max_allocated_storage = 1000
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "test-db"
  username             = "root"
  password             = "Password4321!"
  port = 3306
  parameter_group_name = "default.mysql5.7"
  vpc_security_group_ids = [aws_security_group.allow_3306.id]
  db_subnet_group_name = aws_db_subnet_group.private.id
  publicly_accessible = true
}


resource "aws_db_subnet_group" "private" {
  name       = "private_db_subnet"
  subnet_ids = [var.private_db_subnet]
}


resource "aws_security_group" "allow_3306" {
  name        = "allow_3306"
  description = "Allow 3306 inbound traffic"
  vpc_id      = var.vpc-id

  ingress {
    description = "3306 from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.allow-cidr-block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

