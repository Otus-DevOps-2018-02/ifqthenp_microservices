provider "google" {
  version     = "1.14.0"
  credentials = "${file(var.credentials_file)}"
  project     = "${var.project}"
  region      = "${var.region}"
}

resource "google_container_cluster" "primary" {
  description        = "GKE cluster created with Terraform"
  name               = "reddit-cluster"
  zone               = "${var.zone}"
  initial_node_count = "${var.initial_node_count}"

  master_auth {
    username = ""
    password = ""
  }

  node_config {
    disk_size_gb = "${var.disk_size_gb}"
    machine_type = "${var.machine_type}"

    labels {
      app = "reddit"
    }

    tags = "${concat(var.target_tags)}"
  }

  addons_config {
    kubernetes_dashboard {
      disabled = false
    }
  }
}

resource "google_compute_firewall" "firewall_k8s" {
  name    = "kubernetes-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["30000-32767"]
  }

  target_tags   = "${concat(var.target_tags)}"
  source_ranges = "${var.source_ranges}"
}
