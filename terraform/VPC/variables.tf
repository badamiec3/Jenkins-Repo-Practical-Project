variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "subnet_a_cidr_block" {
  default = "10.0.1.0/24"
}

variable "subnet_b_cidr_block" {
  default = "10.0.2.0/24"
}

variable "open_internet" {
  default = "0.0.0.0/0"
}

variable "public_associate_public_ip" {
  description = "Enable for public subnet"
  default = true
}

variable "private_associate_public_ip" {
  description = "Disable for private subnet"
  default = false
}