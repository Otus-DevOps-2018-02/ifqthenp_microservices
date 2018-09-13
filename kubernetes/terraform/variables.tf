variable "credentials_file" {
  description = "Service account private key in JSON format"
}

variable "project" {
  description = "Project ID"
}

variable "region" {
  description = "Region"
  default     = "europe-west2"
}

variable "zone" {
  description = "The zone that the machine should be created in"
  default     = "europe-west2-a"
}

variable "initial_node_count" {
  description = "The number of nodes to create in this cluster"
  default     = 2
}

variable "disk_size_gb" {
  description = "Size of the disk attached to each node, specified in GB"
  default     = 20
}

variable "machine_type" {
  description = "The name of a Google Compute Engine machine type"
  default     = "n1-standard-2"
}

variable "target_tags" {
  description = "The list of target tags for network firewalls applied to all nodes"
  default     = ["k8s"]
}

variable "source_ranges" {
  description = "Allowed IP addresses"
  default     = ["0.0.0.0/0"]
}
