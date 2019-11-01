resource "aws_security_group" "securityGroupAurora" {
  name = "${var.projectName}-${var.environment}-Aurora-MySQL"
  description = "Allows requests for Aurora-DB application of ${var.projectName}-${var.environment}"
  vpc_id      = "${module.vpc.vpcId}"
  ingress {
      from_port = 36060
      to_port = 36060
      protocol = "tcp"
      cidr_blocks = ["${var.companyIps}", "${var.vpc_cidr}"]
      description = "Aurora-MySQL from requests from VPC and workstationIps"
   }
   egress {
    protocol    = -1
    from_port   = 0 
    to_port     = 0 
    cidr_blocks = ["${var.anywhere}"]
  }

    tags{
	Name = "Security group for Aurora-DB-Server of ${var.projectName}-${var.environment}"
	}
    
}

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
      cidr_blocks = ["${var.companyIps}", "${var.vpc_cidr}"]
      description = "SSHing from workstationIps workstation"
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

resource "aws_security_group" "natServerSecurityGroup" {
  name = "${var.projectName}-${var.environment}-Security Group of NAT Server"
  description = "Allows ${var.projectName}-${var.environment} private subnets to access Internet"
  vpc_id      = "${module.vpc.vpcId}"
  
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["${var.workstationIps}", "${var.vpc_cidr}"]
      description = "SSHing from workstationIps workstation"
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

resource "aws_security_group" "elkServerSecurityGroup" {
  name = "${var.projectName}-${var.environment}-Security Group of ELK Server"
  description = "Used for ELK server of ${var.projectName}-${var.environment}"
  vpc_id      = "${module.vpc.vpcId}"
  
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["${var.workstationIpsIps}", "${module.ec2.bastionIpPrivate}/32"]
      description = "SSHing from workstationIps Workstation and Bastion"
  }
  ingress {
      from_port = 9600
      to_port = 9600
      protocol = "tcp"
      cidr_blocks = ["${var.vpc_cidr}"]
      description = "Elastic Search Service"
  }
  ingress {
      from_port = 5601
      to_port = 5601
      protocol = "tcp"
      cidr_blocks = ["${var.workstationIpsIps}"]
      description ="Kibana Visualization"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.anywhere}"]
    description = "Outbound requests to ALL"
  }
	tags{
	Name = "${var.projectName}-${var.environment}-Security group for ELK Server"
	}
}

resource "aws_security_group" "bastionSecurityGroup" {
  name = "${var.projectName}-${var.environment}-Security Group of Bastion"
  description = "Used to Bastion host of ${var.projectName}-${var.environment}"
  vpc_id      = "${module.vpc.vpcId}"
  
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["${var.workstationIpsIps}"]
      description = "SSHing from workstationIps Workstation"
  }
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
    description = "Access for VPC only"
  }
  egress {
    from_port   = 36060
    to_port     = 36060
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
    description = "Access RDS mysql from Bastion"
  }
	tags{
	Name = "${var.projectName}-${var.environment}- Security group for Bastion host"
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

