resource "aws_security_group" "eks_sg" {
  name = "Allow traffic from vpc"
  description = "Allow SSH"
  vpc_id = var.vpc-id

  ingress {
    from_port = var.inbound_port
    protocol = "tcp"
    to_port = var.inbound_port
    cidr_blocks = [var.allow-cidr-block]  
  }

  egress {
    from_port = var.outbound_port
    protocol = "-1"
    to_port = var.outbound_port
    cidr_blocks = [var.open_internet]  
  }
}

resource "aws_security_group" "allow_80_eks_sg" {
  name = "Allow traffic from internet on 80"
  description = "Allow 80"
  vpc_id = var.vpc-id

  ingress {
    from_port = var.inbound_port_80
    protocol = "tcp"
    to_port = var.inbound_port_80
    cidr_blocks = [var.open_internet]  
  }

  egress {
    from_port = var.outbound_port
    protocol = "-1"
    to_port = var.outbound_port
    cidr_blocks = [var.open_internet]  
  }
}

resource "aws_eks_cluster" "project_cluster" {
  name     = "project-cluster"
  role_arn = var.cluster-service-role-arn
 
  vpc_config {
    endpoint_public_access = true
    subnet_ids         = [var.public_subnet, var.second_public_subnet]
    security_group_ids = [aws_security_group.eks_sg.id, aws_security_group.allow_80_eks_sg.id]
  }
  version = "1.17"
}
 
resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.project_cluster.id
  node_group_name = "Nodes"
  node_role_arn   = var.node-role-arn
  subnet_ids      = [var.public_subnet, var.second_public_subnet]
  ami_type        = var.ami
  instance_types  = var.instance_type
 
  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  remote_access {
    ec2_ssh_key = "jenkins"
  }
 
}



