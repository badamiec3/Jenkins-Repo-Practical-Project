variable "subnet_a_id" {
  description = "imported from vpc module by overriding "
}

variable "ami_id" {
  default = "ami-0dc8d444ee2a42d8a"
}

variable "enable_public_ip" {
  description = "Enable if ec2 should have a public ip address"
  default = true
}

variable "inbound_port" {
  description = "list of ingress ports"
  default = 22
}

variable "outbound_port" {
  description = "list of egress ports"
  default = 0
}

variable "open_internet" {
  description = "CIDR notation for the whole internet"
  default = "0.0.0.0/0"
}