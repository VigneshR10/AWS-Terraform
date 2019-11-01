######################
# variables Defaults #
######################

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

data "aws_availability_zones" "azs" {}

variable "publicSubnetCIDR" {
  default = "10.0.1.0/24"
}

variable "privateSubnetCIDR" {
  default = "10.0.2.0/24"
}

variable "subnetsCount" {

}

variable "publicSubnetId" {
  default = "sub-xxx"
}

variable "privateSubnetId" {
  default = "sub-yyy"
}

variable "privateSubnetIds" {
  type = "list"
  default = []
}

variable "publicSubnetIds" {
  type = "list"
  default = []
}

variable "subnet_id" { 
    default = "subnet-xxx"
 }


variable "ami" {
  default = "ami-xxxyyy"
}

variable "bastionAmi" {
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

variable "projectName" {
  default = "xxx"
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

variable "cluster-name" {
  default = "ProjectA"
}
variable "rdsClusterName" {
  default = "ProjectX"
}

variable "engine" {
  
}

variable "engineMode" {
  
}

variable "databaseName" {
  
}

variable "masterUsername" {
  
}

variable "masterPassword" {
  
}

variable "port" {
  
}

variable "rdsDeletionProtection" {
  
}

variable "backupWindow" {
  
}
variable "skipFinalSnapshot" {
  
}

variable "backtrackWindow" {
  
}


variable "isStorageEncrypted" {
  
}

variable "backupRetentionPeriod" {
  
}
variable "applyImmediately" {
  
}

variable "rdsScalingTarget" {
  
}

variable "anywhere" {
  default = "0.0.0.0/0"
}




variable "rdsInstanceName" {
  default = "ProjectA-db-server"
}

variable "vpcId" {
  default = "vpc-xxx"
}

variable "workstationIps" {
  type = "list"
}

variable "natAmi" {
  default = "i-xxx"
}

variable "vpcSecurityGroupIds" {
  type = "list"
  default = []
}

variable "webServerSecurityGroup" {
  type = "list"
  default = []
}
variable "eksWorkerDesiredCapacity" {
  
}

variable "eksWorkerMinimumCapacity" {
  
}

variable "eksWorkerMaximumCapacity" {
  
}

variable "eksWorkerAmi" {
  
}

variable "eksWorkerInstanceType" {
  
}



variable "desiredCapacityWebserver" {
  
}

variable "maximumCapacityWebserver" {
  
}

variable "minimumCapacityWebserver" {
  
}

variable "webserverInstanceType" {
  
}

variable "emailAddress" {
  type = "list"
  default = ["vigneshr@sample.com"]
}
variable "protocol" {
  default = "email"
}


