resource "aws_security_group" "web_sg" {
  name = "DefaultSGWeb"
  description = "Allow SSH"
  vpc_id = var.vpc-id

  ingress {
    from_port = var.inbound_port
    protocol = "tcp"
    to_port = var.inbound_port
    cidr_blocks = [var.open_internet]  
  }

  egress {
    from_port = var.outbound_port
    protocol = "-1"
    to_port = var.outbound_port
    cidr_blocks = [var.open_internet]  
  }
}

resource "aws_key_pair" "demo_key" {
  key_name = "demokeys"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCq7dwrLXjnt3MWvZ64IvVikB0+Y++bk0Dei5zy6U612iE4cTf/4rqsW2vh/YMM3w813RC2NCZFpQAi4sPeL0r34Y07JpunKABe+qwf89mCo9BIUnD389NX66D2Op8Xs/iFcTKtCKi0PbzOUDJf6yrpOZs98jdwsUaEVAcwROine0mT/qegofyQMHAXBqO6UiYIHPvFQabpdRhxS9zHYNcXfjsgK1+ccLCAuPKnhRRrVKVozAN5GEWlZ+0r+v+RSWfU3rWqWuq7kBjvsX2L6YPgd01ebB11et3SxCqtGMoIp3+0Q09ANvYxpqRqMBxZqd3M/y+bR3BhpfWq84ThCPyP ubuntu@ip-172-31-34-224"
}

resource "aws_instance" "ec2" {
  ami = var.ami_id
  instance_type = var.instance
  key_name = aws_key_pair.demo_key.key_name
  associate_public_ip_address = var.enable_public_ip
  subnet_id = var.subnet_a_id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  
}