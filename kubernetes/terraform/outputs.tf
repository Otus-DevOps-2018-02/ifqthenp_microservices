output "endpoint" {
  value = "${google_container_cluster.primary.endpoint}"
}

output "instance_group_urls" {
  value = "${google_container_cluster.primary.instance_group_urls}"
}

output "master_version" {
  value = "${google_container_cluster.primary.master_version}"
}
