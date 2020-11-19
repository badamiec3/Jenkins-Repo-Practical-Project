output "vpcid" {
  value = aws_vpc.vpc.id
}

output "subnetid" {
  value = aws_subnet.subnet_a.id
}