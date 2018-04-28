terraform {
  backend "gcs" {
    bucket = "ifqthenp_microservices_terraform_state"
    prefix = "terraform/stage"
  }
}
