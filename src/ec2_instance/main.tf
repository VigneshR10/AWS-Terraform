resource "aws_instance" "ec2NAT"{
  ami = "${var.natAmi}"
  subnet_id = "${var.subnetId}"
  tenancy = "${var.tenancy}"
  disable_api_termination = "${var.apiTermination}"
  instance_initiated_shutdown_behavior = "${var.instanceInitiatedShutdown}"
  instance_type = "${var.instanceType}"
  associate_public_ip_address = "${var.associatePublicIp}"
  vpc_security_group_ids = ["${var.natServerSecurityGroup}"]
  key_name = "${var.keyName}"
  source_dest_check = false
  tags{
     Name = "${var.projectName}-${var.environment}-NAT"
     Environment = "${var.environment}"
  }
}
resource "aws_instance" "bastion"{
  ami = "${var.bastionAmi}"
  tenancy = "${var.tenancy}"
  subnet_id = "${var.subnetId}"
  disable_api_termination = "${var.apiTermination}"
  instance_initiated_shutdown_behavior = "${var.instanceInitiatedShutdown}"
  instance_type = "t2.micro"
  associate_public_ip_address = "${var.associatePublicIp}"
  vpc_security_group_ids = ["${var.bastionSecurityGroup}"]
  key_name = "${var.keyName}"
  source_dest_check = "${var.sourceDestCheck}"
  tags{
     Name = "${var.projectName}-${var.environment}-Bastion"
     Envirionment = "${var.environment}"
  }
}

resource "aws_instance" "ec2ELK"{
  ami = "${var.ami}"
  tenancy = "${var.tenancy}"
  subnet_id = "${var.subnetId}"
  disable_api_termination = "${var.apiTermination}"
  instance_initiated_shutdown_behavior = "${var.instanceInitiatedShutdown}"
  instance_type = "${var.instanceType}"
  associate_public_ip_address = "${var.associatePublicIp}"
  vpc_security_group_ids = ["${var.elkServerSecurityGroup}"]
  key_name = "${var.keyName}"
  source_dest_check = "${var.sourceDestCheck}"
  tags{
     Name = "${var.projectName}-${var.environment}-ELK"
     Envirionment = "${var.environment}"
  }
}


# resource "aws_instance" "ec2"{
#   ami = "${var.ami}"
#   #availability_zone = "${data.aws_availability_zones.available.names[0]}"
#   tenancy = "${var.tenancy}"
#   subnet_id = "${var.subnetId}"
#   disable_api_termination = "${var.apiTermination}"
#   instance_initiated_shutdown_behavior = "${var.instanceInitiatedShutdown}"
#   instance_type = "${var.instanceType}"
#   associate_public_ip_address = "${var.associatePublicIp}"
#   key_name = "${var.keyName}"
#   vpc_security_group_ids = ["${var.webServerSecurityGroup}"]
#   source_dest_check = "${var.sourceDestCheck}"
#   tags{
#      Name = "${var.projectName}-Webserver"
#      Envirionment = "${var.environment}"
#   }
# }