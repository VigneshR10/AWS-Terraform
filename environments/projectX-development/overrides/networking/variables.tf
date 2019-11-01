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

variable "publicSubnetCIDR" {
  default = "10.0.1.0/24"
}

variable "privateSubnetCIDR" {
  default = "10.0.2.0/24"
}

variable "subnetsCount" {
  default = 3
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

variable "subnetIds" {
  default = []
}

variable "natAmi" {
  default = "ami-029dbaca987ff4afe"
}

variable "natInstanceId" {
  default = "i-xxx"
}

variable "bastionInstanceId" {
  default = "i-xxx"
}

variable "projectName" {
  default = "XXX"
}

variable "cluster-name" {
  default = "XXX"
}

variable "anywhere" {
  default = "0.0.0.0/0"
}

data "aws_availability_zones" "azs" {}

locals {
    commonTags = "${map(
        "kubernetes.io/cluster/${var.cluster-name}", "shared"
    )}"
}
