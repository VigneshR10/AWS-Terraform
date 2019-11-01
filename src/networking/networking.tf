############
# Networking
############

resource "aws_vpc" "VPC_Prod" {
  cidr_block = "${var.vpc_cidr}"
  instance_tenancy = "default"
  enable_dns_support = "${var.enable_dns_support}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  tags = "${merge(
    local.commonTags,
    map(
        "Name", "${var.projectName}-${var.environment}-VPC"
    )
)}"
}

resource "aws_subnet" "PublicSubnets" {
  count = 3
  availability_zone = "${data.aws_availability_zones.azs.names[count.index]}"
  vpc_id = "${aws_vpc.VPC_Prod.id}"
  cidr_block = "${cidrsubnet("${aws_vpc.VPC_Prod.cidr_block}", 8, "${count.index}")}"
  map_public_ip_on_launch = true
  tags = "${merge(
    local.commonTags,
    map(
        "Name", "${var.projectName}-${var.environment}-${data.aws_availability_zones.azs.names[count.index]}-public-subnet"
    )
)}"
}

resource "aws_subnet" "PrivateSubnets"{
  count = 3
  availability_zone = "${data.aws_availability_zones.azs.names[count.index]}"
  vpc_id = "${aws_vpc.VPC_Prod.id}"
  cidr_block = "${cidrsubnet("${aws_vpc.VPC_Prod.cidr_block}", 8, "${count.index}"+3)}"
  map_public_ip_on_launch = false

  tags = "${merge(
    local.commonTags,
    map(
        "Name", "${var.projectName}-${var.environment}-${data.aws_availability_zones.azs.names[count.index]}-private-subnet",
        "kubernetes.io/role/internal-elb", 1
    )
)}"
}

resource "aws_internet_gateway" "internetGateway" {
  vpc_id = "${aws_vpc.VPC_Prod.id}"

  tags {
    Name = "${var.projectName}-${var.environment}-Internet-Gateway"
  }
}

resource "aws_route_table" "routeTablePublic" {
  vpc_id = "${aws_vpc.VPC_Prod.id}"
  route {
    cidr_block = "${var.anywhere}"
    gateway_id = "${aws_internet_gateway.internetGateway.id}"
  }

  tags {
    Name = "${var.projectName}-${var.environment}-Route_table_Public_Subnet"
  }
}

resource "aws_route_table" "routeTablePrivate" {
  vpc_id = "${aws_vpc.VPC_Prod.id}"
  route {
    cidr_block = "${var.anywhere}"
    instance_id = "${var.natInstanceId}"
  }
  
  tags {
    Name = "${var.projectName}-${var.environment}-Route_table_Private_Subnet"
  }
}

resource "aws_route_table_association" "routeTableAssociationPublic" {
  count		 = "${length(data.aws_availability_zones.azs.names)}"
  subnet_id      = "${element(aws_subnet.PublicSubnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.routeTablePublic.id}"
}

resource "aws_route_table_association" "routeTableAssociationPrivate" {
  count		 = "${length(data.aws_availability_zones.azs.names)}"
  subnet_id      = "${element(aws_subnet.PrivateSubnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.routeTablePrivate.id}"
}

resource "aws_eip" "nat" {
  vpc = true
  instance = "${var.natInstanceId}"
}

resource "aws_eip" "bastion" {
  vpc = true
  instance = "${var.bastionInstanceId}"
}
resource "aws_db_subnet_group" "subnetGroup" {
  name       = "${var.projectName}-${var.environment}-subnet group"
  description= "The subnets used to form aurora-cluster for ${var.projectName} ${var.environment}"
  subnet_ids = ["${aws_subnet.PrivateSubnets.*.id}"]


  tags {
    Name = "${var.projectName}-${var.environment}-Aurora subnet group"
  }
}

