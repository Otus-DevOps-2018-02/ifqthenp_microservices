terraform {
  backend "gcs" {
    bucket = "ifqthenp_gitlab_terraform_state"
    prefix = "terraform/stage"
  }
}
