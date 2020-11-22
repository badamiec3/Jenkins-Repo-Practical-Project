variable "cluster-service-role-arn" {
    default = "arn:aws:iam::560460596452:role/eksClusterRole"
}

variable "public_subnet" {
    description = "id of public subnet"
}

variable "second_public_subnet" {
    description = "id of second public subnet"
}

variable "inbound_port" {
  description = "ssh"
  default = 22
}

variable "inbound_port_80" {
  description = "http"
  default = 80
}

variable "allow-cidr-block" {
    description = "Allow ssh traffic from vpc"
    default = "10.0.0.0/16"
    }

variable "outbound_port" {
  description = "list of egress ports"
  default = 0
}

variable "open_internet" {
  description = "CIDR notation for the whole internet"
  default = "0.0.0.0/0"
}

variable "vpc-id" {
    description = "id of vpc"
}

variable "node-role-arn" {
    default = "arn:aws:iam::560460596452:role/NodeInstanceRole"
}

variable "ami" {
    default = "AL2_x86_64"
}

variable "instance_type" {
    default = "t3.medium"
}


