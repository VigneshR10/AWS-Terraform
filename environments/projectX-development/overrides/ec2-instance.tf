module "ec2" {
  source = "./ec2_instance"
  subnetId = "${module.vpc.publicSubnetId}"
  natAmi = "${var.natAmi}"
  instanceType = "${var.instanceType}"
  keyName = "${aws_key_pair.rtMessages.key_name}"
  instanceInitiatedShutdown = "${var.instanceInitiatedShutdown}"
  apiTermination = "${var.apiTermination}"
  tenancy = "${var.tenancy}"
  associatePublicIp = "${var.associatePublicIp}"
  natServerSecurityGroup = ["${aws_security_group.natServerSecurityGroup.id}"]
  environment = "${var.environment}"
  projectName = "${var.projectName}"
}

data "aws_instances" "webserverInstances" {

  filter {
    name   = "tag:Name"
    values = ["rt-messages-Webserver"]
  }

  instance_state_names = ["running", "stopped"]
}