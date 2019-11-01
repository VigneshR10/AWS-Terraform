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
variable "region" {
  default = "us-west-2"
}

data "aws_availability_zones" "azs" {  }

variable "publicSubnetCIDR" {
  default = "10.0.1.0/24"
}

variable "privateSubnetCIDR" {
  default = "10.0.2.0/24"
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

variable "dbSubnetGroup" {
  default = "sub-xxx"
}

variable "securityGroupIds" {
    type = "list"
    default = [,]
}

variable "vpcId" {
  default = "vpc-xxx"
}

variable "availabilityZonesRDS" {
  type = "list"
  default = []
}

variable "engine" {
  default = "aurora-mysql"
}

variable "engineMode" {
  default = "provisioned"
}

variable "databaseName" {
  default = "aurora"
}

variable "masterUsername" {
  default = "dbAdmin"
}

variable "masterPassword" {
  default = "dbMasterPassword"
}

variable "rdsReplicaMinimumCapacity" {
  default = 1
}
variable "rdsReplicaMaximumCapacity" {
  default = 15
}

variable "rdsScalingTarget" {
  default = 70
}



variable "port" {
  default = 3306
}

variable "dbInstanceClass" {
  default = "db.t2.medium"
}

variable "applyImmediately" {
  default = true
}

variable "isStorageEncrypted" {
  default = true
}

variable "isPubliclyAccessible" {
  default = false
}

variable "rdsDeletionProtection" {
  default = true
}

variable "backupWindow" {
  default = "10:30-11:00"
}


variable "skipFinalSnapshot" {
  default = true
}

variable "backtrackWindow" {
  default = 0
}

variable "backupRetentionPeriod" {
  default = 1
}


variable "availabilityZoneRDS" {
  default = "zone-xxx"
}

variable "rdsClusterName" {
  default = "ProjectX"
}

variable "projectName" {
  default ="XXX"
}

variable "rdsInstanceName" {
  default = "ProjectX"
}


data "aws_availability_zones" "azsRDS" {}
