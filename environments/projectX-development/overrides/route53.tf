resource "aws_route53_record" "recordELB" {
  zone_id = "${data.aws_route53_zone.tmaticscomZone.id}"
  name    = "${var.projectName}-${var.environment}.tmatics.com"
  type    = "CNAME"
  ttl     = "120"
  records = ["${aws_lb.webServerLoadBalancer.dns_name}"]
}
data "aws_route53_zone" "tmaticscomZone" {
  name         = "tmatics.com."
  private_zone = false
}

resource "aws_route53_record" "cert_validation" {
  name    = "${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_type}"
  zone_id = "${data.aws_route53_zone.tmaticscomZone.id}"
  records = ["${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}