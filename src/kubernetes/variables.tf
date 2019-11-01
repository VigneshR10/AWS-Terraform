variable "cluster-name"{
	default = "teezle-Master"
}

variable "vpc_cidr"{
	type = "string"
	default = "10.0.0.0/16"
}

variable "public_subnet_cidr"{
	type = "string"
	default = "10.0.1.0/24"
}

variable "public_subnet_cidr_1"{
	type = "string"
	default = "10.0.2.0/24"
}

#data "aws_availability_zones" "available" {}

variable "availability_zone"{
	default = "eu-west-2a"
}

variable "project_a_key"{
	#type = "string"
	default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFWsebI8/kr1o5GLyq+OG8pQT3HfvUdqH6Gfvmn0/CLD/nwqeIFTebdM7J0GNlrMc3drSVQPIetpH6MwBCybo8ly1txz5q1oo0RavbplpW8zLmrRlBftamVYaRZXXBAFG/wMK5xluPDuKVSIakcxHwuNlQbW7DDsPJ1C6urKuKOGN0YzxtZpTU+JTalDiYD77Pveur2dOYBTWl3GL8YLqtqz0wyBvq2W58HHrRlIUDH3bukIsJ27UQoPeiEfVGPEvz8FWraOc3m638bG1LO+5FZM3gEh4sHDuqrTMfI+NWy/CQrEO9v/6uGpX4iKw49pspqHi/VrpSa3d58yfDdEoj root"
}

variable "project_a_key_nat"{
	#type = "string"
	default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFWsebI8/kr1o5GLyq+OG8pQT3HfvUdqH6Gfvmn0/CLD/nwqeIFTebdM7J0GNlrMc3drSVQPIetpH6MwBCybo8ly1txz5q1oo0RavbplpW8zLmrRlBftamVYaRZXXBAFG/wMK5xluPDuKVSIakcxHwuNlQbW7DDsPJ1C6urKuKOGN0YzxtZpTU+JTalDiYD77Pveur2dOYBTWl3GL8YLqtqz0wyBvq2W58HHrRlIUDH3bukIsJ27UQoPeiEfVGPEvz8FWraOc3m638bG1LO+5FZM3gEh4sHDuqrTMfI+NWy/CQrEO9v/6uGpX4iKw49pspqHi/VrpSa3d58yfDdEoj root"
}


variable "region"{
	default = "eu-west-2"
}

variable "ubuntu_18_04"{
	default = "ami-0427e8367e3770df1"
}

variable "nat_ami"{
	default = "ami-1ec1407a"
}


/*data "aws_ami" "eks-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-v*"]
  }

  most_recent = true
  owners      = ["self"] # Amazon EKS AMI Account ID
}*/

/*data "aws_ami" "eks-worker" {
most_recent = true
  filter {
    name   = "name"
    values = ["amazon-eks-*"]
   }
}*/

variable "eks_ami_London"{
	default = "ami-0c7388116d474ee10"
	}

variable "eks_ami_North_Virginia" {
	default = "ami-0abcb9f9190e867ab"
}

variable "eksWorkerAmi" {
	default = "ami-0923e4b35a30a5f53"
}

variable "workerInstanceType" {
	default = "t2.medium"
}

variable "eksWorkerDesiredCapacity" {
	default = 2
}
variable "eksWorkerMinimumCapacity" {
	default = 2
}
variable "eksWorkerMaximumCapacity" {
	default = 4
}


variable "publicSubnetId" {
  default = "public-xxx"
}

variable "privateSubnetId" {
  default = "private-xxx"
}

variable "privateSubnetIds" {
	type = "list"
	default = []
}


variable "vpcId" {
  default = "vpc-xxx"
}

variable "workerInstanceProfile" {
  default = "ami-xxx"
}

variable "eksClusterRole" {
  default = "xxx"
}

variable "iamRoleNode" {
  default = "xxx"
}

variable "publicSubnetIds" {
	type = "list"
	default = []
}

variable "environment" {
	default = "TEST"
}

variable "projectName" {
	default = "Project"
}


