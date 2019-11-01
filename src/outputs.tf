output "vpcId" {
  value = "${module.vpc.vpcId}"
}

output "privateSubnetIds" {
  value = "${module.vpc.privateSubnetIds}"
}

output "rdsEndPoint" {
  value = "${module.rds.rdsEndPoint}"
}

output "rdsClusterCustomEndpoint" {
  value = "${module.rds.rdsClusterCustomEndPoint}"
}

output "configMap" {
  value = "${module.kubernetes.config_map_aws_auth}"
}

output "kubeConfig" {
  value = "${module.kubernetes.kubeconfig}"
}

output "webserverIps" {
  value = "${data.aws_instances.webserverInstances.private_ips}"
}

output "bastionIp" {
  value = "${module.ec2.bastionIp}"
}

output "bastionIpPrivate" {
  value = "${module.ec2.bastionIpPrivate}"
}
output "arn" {
  value       = "${aws_cloudformation_stack.snsTopicWebserver.outputs["ARN"]}"
  description = "Email SNS topic ARN"
}