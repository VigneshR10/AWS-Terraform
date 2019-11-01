# output "publicIp" {
#   value = "${aws_instance.ec2.public_ip}"
# }

output "natInstanceId" {
  value = "${aws_instance.ec2NAT.id}"
}

output "bastionInstanceId" {
  value = "${aws_instance.bastion.id}"
}

output "bastionIp" {
  value = "${aws_instance.bastion.public_ip}"
}

output "bastionIpPrivate" {
  value = "${aws_instance.bastion.private_ip}"
}




# output "webServerId" {
#   value = "${aws_instance.ec2.id}"
# }

