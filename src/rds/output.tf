output "rdsEndPoint" {
  value = "${aws_rds_cluster.aurora.endpoint}"
}

output "rdsClusterCustomEndPoint" {
  value = "${aws_rds_cluster_endpoint.rdsClusterEndPoint.endpoint}"
}
