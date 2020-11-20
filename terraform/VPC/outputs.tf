output "vpcid" {
  value = aws_vpc.vpc.id
}

output "subnetid" {
  value = aws_subnet.subnet_a.id
}

output "privatesubnetid" {
  value = aws_subnet.subnet_b.id
}

output "secondprivatesubnetid" {
  value = aws_subnet.subnet_c.id
}