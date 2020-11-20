resource "aws_security_group" "install_sg" {
  name = "Allow ssh from install vm"
  description = "Allow SSH"
  vpc_id = var.vpc-id

  ingress {
    from_port = var.inbound_port
    protocol = "tcp"
    to_port = var.inbound_port
    cidr_blocks = [var.terraform_vm_ip]  
  }

  egress {
    from_port = var.outbound_port
    protocol = "-1"
    to_port = var.outbound_port
    cidr_blocks = [var.open_internet]  
  }
}


resource "aws_key_pair" "install_vm_key" {
  key_name = "install_vm_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYfjWg1kQSN/PR2zlvKoXtkCN8JmI0qPK6B1ekjwMl/UTWlTHryEXKbwie2gjTDr55smQ3+ZpRQlOxA9vANoNBhMY6zkFyeNCzwLWxydaWf3X1Or1paq8HJCbAOmq0hxGwyeam6HY+60BvJH83MlgCxC6KGr1RsfFZ0vYjb5swhSiRKMcbvI3tY4bcHOliRxl4zz7vcSmwNFidnDPP1xh1ougyudTFvxhnwpzmjLUZ/j81gOCP3jZUMbgzSEm0HLz2SIFh0dDd6EUaUtYtY3BWxRto/gRLy+znEcAEExvoVA/SfjFVNtGnfXhAOVl5fst411zNOoVF5E9duwAMlzYV ubuntu@ip-172-31-45-205"
}

resource "aws_instance" "ec2" {
  ami = var.ami_id
  instance_type = var.instance
  key_name = aws_key_pair.install_vm_key.key_name
  associate_public_ip_address = var.enable_public_ip
  subnet_id = var.subnet_a_id
  vpc_security_group_ids = [aws_security_group.install_sg.id]
  
}




