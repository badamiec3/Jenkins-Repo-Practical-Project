resource "aws_db_instance" "db" {
  allocated_storage    = var.allocated-storage
  max_allocated_storage = var.max-allocated-storage
  storage_type         = var.storage-type
  engine               = var.engine
  engine_version       = var.engine-version
  instance_class       =  var.instance-class
  name                 = var.db-name
  identifier = var.db-name
  username             = "root"
  password             = "Password1234!"
  port = var.port
  parameter_group_name = var.parameter-group-name
  vpc_security_group_ids = [aws_security_group.allow_3306.id]
  db_subnet_group_name = aws_db_subnet_group.private.id
  publicly_accessible = var.pub-access
}

resource "aws_db_instance" "test-db" {
  allocated_storage    = var.allocated-storage
  max_allocated_storage = var.max-allocated-storage
  storage_type         = var.storage-type
  engine               = var.engine
  engine_version       = var.engine-version
  instance_class       = var.instance-class
  name                 = var.test-db-name
  identifier = var.test-db-name
  username             = "root"
  password             = "Password4321!"
  port = var.port
  parameter_group_name = var.parameter-group-name
  vpc_security_group_ids = [aws_security_group.allow_3306.id]
  db_subnet_group_name = aws_db_subnet_group.private.id
  publicly_accessible = var.pub-access
}


resource "aws_db_subnet_group" "private" {
  name       = "private_db_subnet"
  subnet_ids = [var.private_db_subnet, var.second_private_db_subnet]
}


resource "aws_security_group" "allow_3306" {
  name        = "allow_3306"
  description = "Allow 3306 inbound traffic"
  vpc_id      = var.vpc-id

  ingress {
    description = "3306 from VPC"
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = [var.allow-cidr-block]
  }

  egress {
    from_port   = var.egress-port
    to_port     = var.egress-port
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

