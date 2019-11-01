resource "aws_route53_record" "recordELB" {
  zone_id = "sample4KWGC63B3"
  name    = "${var.projectName}-${var.environment}.sample.com"
  type    = "CNAME"
  ttl     = "120"
  records = ["${aws_lb.webServerLoadBalancer.dns_name}"]
}

resource "aws_route53_record" "recordELBApi" {
  zone_id = "sample4KWGC63B3"
  name    = "api-${var.projectName}-${var.environment}.sample.com"
  type    = "CNAME"
  ttl     = "120"
  records = ["aws_lb.ApiServerLoadBalancer.dns_name"]
}

