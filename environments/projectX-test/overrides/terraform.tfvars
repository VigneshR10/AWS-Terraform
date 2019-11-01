###########
# variables
###########

vpc_cidr = "10.10.0.0/16"
enable_dns_hostnames = true
enable_dns_support = true

region = "eu-west-2"

publicSubnetCIDR = "10.10.1.0/24"
privateSubnetCIDR = "10.10.10.0/24"
ami = "ami-xxx"
environment = "ProjectA"

instanceType = "t2.medium"
instanceInitiatedShutdown = "stop"
apiTermination = false
tenancy = "default"
associatePublicIp = true
sourceDestCheck = true
