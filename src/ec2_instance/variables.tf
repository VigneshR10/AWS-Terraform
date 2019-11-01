###########
# variables
###########

variable "vpc_cidr"{
  type = "string"
  default = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  default = true
}

variable "enable_dns_support" {
  default = true
}

variable "region"{
  default = "eu-west-2"
}

data "aws_availability_zones" "azs" {}

variable "publicSubnetCIDR" {
  default = "10.0.1.0/24"
}

variable "privateSubnetCIDR" {
  default = "10.0.2.0/24"
}

variable "subnet_id" {
  default = "subnet-xxx"
 }


variable "ami" {
  default = "xxxyyy"
}

variable "environment" {
  default = "test"
}

variable "instanceType" {
  default = "t2.micro"
}

variable "instanceInitiatedShutdown" {
  default = "stop"
}

variable "apiTermination" {
  default = false
}

variable "tenancy" {
  default = "default"
}

variable "associatePublicIp" {
  default = false
}

variable "sourceDestCheck" {
  default = true
}

variable "natAmi" {
  default = "i-xxx"
}

variable "bastionAmi" {
  default = "ami-01a76e79ae757048d"
}

variable "subnetId" {
  default = "sub-xxx"
}

variable "projectName" {
  default = "xxx"
}

variable "keyName" {
  default = "xxx"
}

variable "vpcSecurityGroupIds" {
  type = "list"
  default = []
}

variable "webServerSecurityGroup" {
  type = "list"
  default = []
}

variable "bastionSecurityGroup" {
  type = "list"
  default = []
}

variable "natServerSecurityGroup" {
  type = "list"
  default = []
}

variable "elkServerSecurityGroup" {
  type = "list"
  default = []
}

