resource "aws_security_group" "webServerSecurityGroup" {
  name = "${var.projectName}-${var.environment}- Security Group of Webserver"
  description = "Allow requests from worldwide for ${var.projectName}-${var.environment} Webserver"
  vpc_id      = "${module.vpc.vpcId}"
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["${var.anywhere}"]
      description = "Web requests"
  }
  ingress {
      from_port = 8899
      to_port = 8899
      protocol = "tcp"
      cidr_blocks = ["${var.anywhere}"]
      description = "Web requests"
  }
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["${var.teezleIps}", "${var.vpc_cidr}"]
      description = "SSHing from teezle workstation"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.anywhere}"]
    description = "Outbound requests to ALL"
  }
	tags{
	Name = "${var.projectName}-${var.environment}-Security group for WebServer"
	}
}


resource "aws_security_group" "webServerLoadBalancerSecurityGroup" {
  name        = "Webserver Load Balancer security group of ${var.projectName}-${var.environment}"
  description = "Security group for the Webserver Load Balancer of ${var.projectName}-${var.environment}"
  vpc_id      = "${module.vpc.vpcId}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.anywhere}"]
    description = "Web requests"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.anywhere}"]
    description = "Web requests secured"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["${var.anywhere}"]
    description = "Outbound requests to ALL"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name        = "${var.projectName}-${var.environment}-Webserver Load Balancer"
  }
}

resource "aws_security_group" "natServerSecurityGroup" {
  name = "${var.projectName}-${var.environment}-Security Group of NAT Server"
  description = "Allows ${var.projectName}-${var.environment} private subnets to access Internet"
  vpc_id      = "${module.vpc.vpcId}"
  
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["${var.teezleIps}", "${var.vpc_cidr}"]
      description = "SSHing from teezle workstation"
  }
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["${var.vpc_cidr}"]
      description = "NAT rule for VPC resources http"
  }
  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["${var.vpc_cidr}"]
      description = "NAT rule for VPC resources https"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.anywhere}"]
    description = "Outbound requests to ALL"
  }
	tags{
	Name = "${var.projectName}-${var.environment}-Security group for NAT Server"
	}
}