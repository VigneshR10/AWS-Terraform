module "ec2" {
  source = "./ec2_instance"
  subnetId = "${module.vpc.publicSubnetId}"
  ami = "${var.ami}"
  natAmi = "${var.natAmi}"
  bastionAmi = "${var.bastionAmi}"
  instanceType = "${var.instanceType}"
  keyName = "${aws_key_pair.projectX.key_name}"
  instanceInitiatedShutdown = "${var.instanceInitiatedShutdown}"
  apiTermination = "${var.apiTermination}"
  tenancy = "${var.tenancy}"
  associatePublicIp = "${var.associatePublicIp}"
  natServerSecurityGroup = ["${aws_security_group.natServerSecurityGroup.id}"]
  elkServerSecurityGroup = ["${aws_security_group.elkServerSecurityGroup.id}"]
  bastionSecurityGroup = ["${aws_security_group.bastionSecurityGroup.id}"]
  sourceDestCheck = "${var.sourceDestCheck}"
  environment = "${var.environment}"
  projectName = "${var.projectName}"
}

data "aws_instances" "webserverInstances" {

  filter {
    name   = "tag:Name"
    values = ["projectX-Webserver"]
  }

  instance_state_names = ["running", "stopped"]
}