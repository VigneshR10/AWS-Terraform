resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = "${var.projectName}-${var.environment}-cluster"
  availability_zones      = ["${data.aws_availability_zones.azs.names[0]}", "${data.aws_availability_zones.azs.names[1]}", "${data.aws_availability_zones.azs.names[2]}"]
  db_subnet_group_name    = "${var.dbSubnetGroup}"
  engine        	        = "${var.engine}"
  engine_mode             = "${var.engineMode}"
  database_name           = "${var.databaseName}"
  master_username         = "${var.masterUsername}"
  master_password         = "${var.masterPassword}"
  port                    = "${var.port}"
  backup_retention_period = "${var.backupRetentionPeriod}"
  storage_encrypted       = "${var.isStorageEncrypted}"
  skip_final_snapshot     = "${var.skipFinalSnapshot}"
  deletion_protection     = "${var.rdsDeletionProtection}"
  backtrack_window        = "${var.backtrackWindow}"
  vpc_security_group_ids  = ["${var.securityGroupIds}"]
  apply_immediately       = "${var.applyImmediately}"
  preferred_backup_window = "${var.backupWindow}"
  tags{
	Name = "${var.projectName}-${var.environment}-Aurora-Cluster"
 }
}

resource "aws_rds_cluster_instance" "cluster_instance" {
  cluster_identifier   = "${aws_rds_cluster.aurora.id}"
  identifier	         = "${var.projectName}-${var.environment}-db-server"
  instance_class       = "${var.dbInstanceClass}"
  engine               = "${var.engine}"
  publicly_accessible  = "${var.isPubliclyAccessible}"
  db_subnet_group_name = "${var.dbSubnetGroup}"
  availability_zone    = "${data.aws_availability_zones.azs.names[0]}"
  apply_immediately    = "${var.applyImmediately}"
  promotion_tier       = 0
  tags{
	Name = "${var.projectName}-${var.environment}-Aurora cluster db instance Primary"
 }
}

resource "aws_rds_cluster_instance" "cluster_instance1" {
  cluster_identifier   = "${aws_rds_cluster.aurora.id}"
  identifier	         = "${var.projectName}-${var.environment}-db-server-1"
  instance_class       = "${var.dbInstanceClass}"
  engine               = "${var.engine}"
  publicly_accessible  = "${var.isPubliclyAccessible}"
  db_subnet_group_name = "${var.dbSubnetGroup}"
  availability_zone    = "${data.aws_availability_zones.azs.names[1]}"
  apply_immediately    = "${var.applyImmediately}"
  promotion_tier       = 1
  tags{
	Name = "${var.projectName}-${var.environment}-Aurora cluster db instance"
 }
}

resource "aws_appautoscaling_target" "rdsReplicas" {
  service_namespace  = "rds"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  resource_id        = "cluster:${aws_rds_cluster.aurora.id}"
  min_capacity       = "${var.rdsReplicaMinimumCapacity}"
  max_capacity       = "${var.rdsReplicaMaximumCapacity}"
}

resource "aws_appautoscaling_policy" "rdsReplicasScalingPolicy" {
  name               = "${var.projectName}-${var.environment}-RDSAutoScalingCPU"
  service_namespace  = "${aws_appautoscaling_target.rdsReplicas.service_namespace}"
  scalable_dimension = "${aws_appautoscaling_target.rdsReplicas.scalable_dimension}"
  resource_id        = "${aws_appautoscaling_target.rdsReplicas.resource_id}"
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "RDSReaderAverageCPUUtilization"
    }

    target_value       = "${var.rdsScalingTarget}"
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}

resource "aws_rds_cluster_endpoint" "rdsClusterEndPoint" {
  cluster_identifier          = "${aws_rds_cluster.aurora.id}"
  cluster_endpoint_identifier = "rdsreaderandwriter"
  custom_endpoint_type        = "ANY"
}

/*

variable dbSubnetGroup
variable securityGroupIds

*/

