provider "google" {
  version = "1.9.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "storage-bucket" {
  source  = "SweetOps/storage-bucket/google"
  version = "0.1.1"

  name = ["ifqthenp_gitlab_terraform_state"]
}

output storage-bucket_url {
  value = "${module.storage-bucket.url}"
}
