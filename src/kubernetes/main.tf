resource "aws_eks_cluster" "eksCluster" {
  name            = "${var.cluster-name}"
  role_arn        = "${var.eksClusterRole}"

  vpc_config {
    security_group_ids = ["${aws_security_group.eksClusterSecurityGroup.id}"]
    subnet_ids         = ["${var.publicSubnetIds}"]
  }

}

#############LAUNCH CONFIGURATION###############

locals {
  workerNodeUserData = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.eksCluster.endpoint}' --b64-cluster-ca '${aws_eks_cluster.eksCluster.certificate_authority.0.data}' '${var.cluster-name}'
USERDATA
}

resource "aws_launch_configuration" "workerNodeLaunchConfigurationProjectA" {
  associate_public_ip_address = true
  iam_instance_profile        = "${var.workerInstanceProfile}"
  image_id                    = "${var.eksWorkerAmi}"
  instance_type               = "${var.workerInstanceType}"
  name_prefix                 = "${var.projectName}-Worker"
  security_groups             = ["${aws_security_group.eksWorkerSecurityGroup.id}"]
  user_data_base64            = "${base64encode(local.workerNodeUserData)}"
  
  lifecycle {
    create_before_destroy = true
  }
}


###############AUTO SCALING GROUP################

resource "aws_autoscaling_group" "demo" {
  desired_capacity     = "${var.eksWorkerDesiredCapacity}"
  launch_configuration = "${aws_launch_configuration.workerNodeLaunchConfigurationProjectA.id}"
  max_size             = "${var.eksWorkerMaximumCapacity}"
  min_size             = "${var.eksWorkerMinimumCapacity}"
  name                 = "${var.projectName}-${var.environment}-ASG"
  vpc_zone_identifier  = ["${var.publicSubnetIds}"]
  termination_policies = ["OldestInstance"]

  tag {
    key                 = "Name"
    value               = "${var.projectName}-${var.environment}-Workers"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster-name}"
    value               = "owned"
    propagate_at_launch = true
  }
}


