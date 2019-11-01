resource "aws_lb_target_group" "webServerLoadBalancerTargetGroup" {
  name = "${var.projectName}-${var.environment}-Webserver"
  port = 8899
  protocol = "HTTP"
  vpc_id = "${module.vpc.vpcId}"
  deregistration_delay = 5
  health_check {
    interval = 30
    path = "/"
    healthy_threshold = 2
    unhealthy_threshold = 10
    timeout = 10
    matcher = "200-299"
  }
}



