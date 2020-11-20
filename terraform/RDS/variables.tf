variable "private_db_subnet" {
    description = "ID of the private subnet for RDS"
}

variable "allow-cidr-block" {
    description = "Used to allow ec2 and test-ec2 in public subnet to access RDS instances on port 3306"
    default = "10.0.1.0/24"
    }

variable "vpc-id" {
  description = "imported from vpc module"
}




