provider "google" {
  version = "1.9.0"
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_instance" "gitlab-ci" {
  count        = "${var.count}"
  name         = "gitlab-ci-${count.index}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"
  tags         = ["gitlab-ci"]

  boot_disk {
    initialize_params {
      size  = "75"
      type  = "pd-ssd"
      image = "${var.disk_image}"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

resource "google_compute_firewall" "firewall_gitlab" {
  name = "allow-gitlab-ci"

  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = "${var.source_ranges}"
}
