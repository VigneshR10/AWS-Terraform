resource "aws_lb" "webServerLoadBalancer" {
  name = "${var.projectName}-${var.environment}-Webserver" #should not be longer than 32 Character
  internal = false
  load_balancer_type = "application"
  security_groups = ["${aws_security_group.webServerLoadBalancerSecurityGroup.id}"]
  subnets = ["${module.vpc.publicSubnetIds}"]
  idle_timeout = 30
  enable_deletion_protection = false
}

resource "aws_lb_listener" "webServerHttpListener" {
  load_balancer_arn = "${aws_lb.webServerLoadBalancer.arn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.webServerLoadBalancerTargetGroup.arn}"
  }
}

resource "aws_lb_listener_rule" "webServerLoadBalancerListener" {
  listener_arn = "${aws_lb_listener.webServerHttpListener.arn}"

  action {
    type             = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }

    target_group_arn = "${aws_lb_target_group.webServerLoadBalancerTargetGroup.arn}"
  }

  condition {
    field  = "host-header"
    values = ["${var.projectName}-${var.environment}.tmatics.com"]
  }
}

resource "aws_lb_listener" "webServerHttpsListener" {
  load_balancer_arn = "${aws_lb.webServerLoadBalancer.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${aws_acm_certificate.certificate.arn}"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.webServerLoadBalancerTargetGroup.arn}"
  }
}
