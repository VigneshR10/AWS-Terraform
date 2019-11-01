module "vpc" {
  source = "./networking"
  vpc_cidr = "${var.vpc_cidr}"
  subnetsCount = "${var.subnetsCount}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support = "${var.enable_dns_support}"
  projectName = "${var.projectName}"
  cluster-name = "${var.cluster-name}"
  environment = "${var.environment}"
  natInstanceId = "${module.ec2.natInstanceId}"
  bastionInstanceId = "${module.ec2.bastionInstanceId}"
}
