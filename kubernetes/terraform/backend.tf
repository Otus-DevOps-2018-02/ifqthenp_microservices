terraform {
  backend "gcs" {
    bucket = "ifqthenp_k8s_terraform_state"
    prefix = "terraform/k8s"
  }
}
