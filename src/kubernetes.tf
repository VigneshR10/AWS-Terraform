module "kubernetes" {
  source = "./kubernetes"
  vpcId = "${module.vpc.vpcId}"
  eksWorkerAmi = "${var.eksWorkerAmi}"
  workerInstanceType = "${var.eksWorkerInstanceType}"
  eksWorkerDesiredCapacity = "${var.eksWorkerDesiredCapacity}"
  eksWorkerMinimumCapacity = "${var.eksWorkerMinimumCapacity}"
  eksWorkerMaximumCapacity = "${var.eksWorkerMaximumCapacity}"
  publicSubnetIds = "${module.vpc.publicSubnetIds}"
  privateSubnetIds = "${module.vpc.privateSubnetIds}"
  workerInstanceProfile = "${aws_iam_instance_profile.workerInstanceProfile.name}"
  eksClusterRole = "${aws_iam_role.eksClusterRole.arn}"
  iamRoleNode = "${aws_iam_role.eksWorkerRole.arn}"
  projectName = "${var.projectName}"
  environment = "${var.environment}"
}

