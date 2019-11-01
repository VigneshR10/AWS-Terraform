output "vpcId" {
  value = "${aws_vpc.VPC_Prod.id}"
}

output "publicSubnetId" {
  value = "${element(aws_subnet.PublicSubnets.*.id, 1)}"
}

# output "privateSubnetId" {
#   value = "${aws_subnet.PrivateSubnets.id}"
# }

output "dbSubnetGroup" {
  value = "${aws_db_subnet_group.subnetGroup.name}"
}

# output "availabilityZonePrivateSubnet" {
#   value = "${aws_subnet.productionPrivateSubnet.id}"
# }

output "publicSubnetIds" {
  value = "${aws_subnet.PublicSubnets.*.id}"
}

output "privateSubnetIds" {
  value = "${aws_subnet.PrivateSubnets.*.id}"
}
