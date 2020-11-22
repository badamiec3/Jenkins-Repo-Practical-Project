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

resource "aws_security_group" "allow_8080" {
  name = "Allow port 8080 from local machine"
  description = "Allow 8080"
  vpc_id = var.vpc-id

  ingress {
    from_port = var.jenkins_inbound
    protocol = "tcp"
    to_port = var.jenkins_inbound
    cidr_blocks = [var.local-ip]  
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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7dumdlSEjVu3CPwimY7LuiM4fIOLt68Ic6H2E7+GZoemyFPtUMpT+8jSB8l4xWVya8dJlBCE/FWivC82MJH1boe3T5hTjqpARbfheVyBgGjm15GjhfCACUlrGFumEb9NuHOlV5S6ocHji1xi+uLhuNGvqDtMHTOw7zHVDfG0bK00GBi9qAKiQIBaG//T7h0h0qrrGfh1u/BNragqCMSx0kNSsfIy2QABZ1DywlsUemPUMtICS/WK/DHNG7+rszUXOi8TNuWCdyn78v63Ahq4MBjHwFCd8d7fGk5c1Sl5AtfVRf/0J72SzB5AQqsSarvAVOJWmGd40qRnhhReEbTLl ubuntu@ip-172-31-45-205"
}

resource "aws_instance" "ec2" {
  ami = var.ami_id
  instance_type = var.instance
  key_name = aws_key_pair.install_vm_key.key_name
  associate_public_ip_address = var.enable_public_ip
  subnet_id = var.subnet_a_id
  vpc_security_group_ids = [aws_security_group.install_sg.id, aws_security_group.allow_8080.id]
  
}









