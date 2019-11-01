resource "aws_launch_configuration" "webServerLaunchConfiguration" {
  associate_public_ip_address = true
  image_id                    = "ami-0b248ae2058a0495b"
  instance_type               = "${var.webserverInstanceType}"
  name_prefix                 = "${var.projectName}-${var.environment}-Webserver"
  key_name                    = "${aws_key_pair.rtMessages.key_name}"
  user_data                   = "${data.template_file.userDataWebserver.rendered}"
  security_groups             = ["${aws_security_group.webServerSecurityGroup.id}"]
 
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "webServerAutoScalingGroup" {
  desired_capacity     = "${var.desiredCapacityWebserver}"
  launch_configuration = "${aws_launch_configuration.webServerLaunchConfiguration.id}"
  max_size             = "${var.maximumCapacityWebserver}"
  min_size             = "${var.minimumCapacityWebserver}"
  name                 = "${var.projectName}-${var.environment} Webserver ASG"
  vpc_zone_identifier  = ["${module.vpc.publicSubnetIds}"]
  health_check_type    = "ELB"
  health_check_grace_period = 300
  termination_policies = ["NewestInstance"]

  tag {
    key                 = "Name"
    value               = "${var.projectName}-${var.environment}-Webserver"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "webServerAutoScalingPolicy" {
  name                   = "${var.projectName}-${var.environment}-Webserver ASG"
  autoscaling_group_name = "${aws_autoscaling_group.webServerAutoScalingGroup.name}"
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
  predefined_metric_specification {
    predefined_metric_type = "ASGAverageCPUUtilization"
  }
    target_value = 75
}
}

resource "aws_autoscaling_attachment" "webServerAutoScalingGroupAttach" {
  autoscaling_group_name = "${aws_autoscaling_group.webServerAutoScalingGroup.id}"
  alb_target_group_arn   = "${aws_lb_target_group.webServerLoadBalancerTargetGroup.arn}"
}
