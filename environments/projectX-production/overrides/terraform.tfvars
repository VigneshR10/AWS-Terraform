#****************************India Account OREGON REGION****************************#

################################
#           variables          #
################################

######VPC######
vpc_cidr = "10.1.0.0/16"
enable_dns_hostnames = true
enable_dns_support = true
region = "us-west-2"
subnetsCount = 3                           # Be careful, it may vary depend on Region

######EC2###### 
natAmi = "ami-0032ea5ae08aa27a2"
ami = "ami-08692d171e3cf02d6"
bastionAmi = "ami-08692d171e3cf02d6"
environment = "messages"
instanceType = "t2.medium"
desiredCapacityWebserver = 1
maximumCapacityWebserver = 3
minimumCapacityWebserver = 1
webserverInstanceType = "t2.small"
instanceInitiatedShutdown = "stop"
apiTermination = false
tenancy = "default"
associatePublicIp = true
sourceDestCheck = true
projectName = "projectX"

workstationIps = ["xx.xx.45.102/32", "xx.xx.137.178/32"]

######RDS######
availabilityZoneRDS = "us-west-2"
engine = "aurora-mysql"
engineMode = "provisioned"
dbInstanceClass = "db.t2.medium"
databaseName = "aurora"
port = "36060"
masterUsername = "dbAdmin"
masterPassword = "masterPassword"
backupRetentionPeriod = 1
isStorageEncrypted = true
skipFinalSnapshot = true
rdsDeletionProtection = true
backtrackWindow = 0
applyImmediately = true
backupWindow = "10:30-11:00"
rdsScalingTarget = 75


######ELASTIC KUBERNETES######
cluster-name = "eksMasterCluster"
eksWorkerAmi = "ami-0923e4b35a30a5f53"
eksWorkerInstanceType = "t2.medium"
eksWorkerDesiredCapacity = 2
eksWorkerMinimumCapacity = 2
eksWorkerMaximumCapacity = 4


#######SNS NOTIFICATION#######
emailAddress = ["vigneshr@sample.com"]
