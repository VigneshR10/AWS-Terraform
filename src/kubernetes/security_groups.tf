resource "aws_security_group" "eksClusterSecurityGroup" {
  name        = "Project A EKS Cluster Security group"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${var.vpcId}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.projectName}-${var.environment}-EKS Cluster Security group"
  }
}

# OPTIONAL: Allow inbound traffic from your local workstation external IP
#           to the Kubernetes. You will need to replace A.B.C.D below with
#           your real IP. Services like icanhazip.com can help you find this.
resource "aws_security_group_rule" "demo-cluster-ingress-workstation-https" {
  cidr_blocks       = ["xx.xx.137.178/32", "xx.xx.45.102/32"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.eksClusterSecurityGroup.id}"
  to_port           = 443
  type              = "ingress"
}

##################WORKER NODE SECURITY GROUPS######################

resource "aws_security_group" "eksWorkerSecurityGroup" {
  name        = "Project A EKS Worker Security Group"
  description = "Security group for all nodes in the cluster"
  vpc_id      = "${var.vpcId}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${
    map(
     "Name", "${var.projectName}-${var.environment} Workers",
     "kubernetes.io/cluster/${var.cluster-name}", "owned",
    )
  }"
}

resource "aws_security_group_rule" "demo-node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.eksWorkerSecurityGroup.id}"
  source_security_group_id = "${aws_security_group.eksWorkerSecurityGroup.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "demo-node-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.eksWorkerSecurityGroup.id}"
  source_security_group_id = "${aws_security_group.eksClusterSecurityGroup.id}"
  to_port                  = 65535
  type                     = "ingress"
}

############For Cluster#############
resource "aws_security_group_rule" "demo-cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.eksClusterSecurityGroup.id}"
  source_security_group_id = "${aws_security_group.eksWorkerSecurityGroup.id}"
  to_port                  = 443
  type                     = "ingress"
}
