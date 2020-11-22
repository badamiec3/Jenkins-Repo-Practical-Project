variable "private_db_subnet" {
    description = "ID of the private subnet for RDS"
}

variable "second_private_db_subnet" {
    description = "ID of the private subnet for RDS"
}

variable "allow-cidr-block" {
    description = "Used to allow ec2, test-ec2 and RDS to access RDS instances on port 3306"
    default = "10.0.0.0/16"
    }

variable "vpc-id" {
  description = "imported from vpc module"
}

variable "allocated-storage" {
  default = 20
}

variable "max-allocated-storage" {
  default = 1000
}

variable "storage-type" {
  default = "gp2"
}

variable "engine" {
    default = "mysql"
}

variable "engine-version" {
    default = "5.7"
}

variable "instance-class" {
    default = "db.t2.micro"
}

variable "db-name" {
    default = "db"
}

variable "test-db-name" {
    default = "testdb"
}

variable "parameter-group-name" {
    default = "default.mysql5.7"
}

variable "port" {
    default = 3306
}

variable "egress-port" {
    default = 0
}

variable "pub-access" {
    default = true
}




