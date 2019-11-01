resource "aws_acm_certificate" "certificate" {
  domain_name       = "${var.projectName}-${var.environment}.tmatics.com"
  validation_method = "DNS"

  tags = {
    Name = "${var.projectName}-${var.environment}"
  }
  lifecycle {
    create_before_destroy = true
  }
}
