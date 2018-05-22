variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west2"
}

variable zone {
  description = "The zone that the machine should be created in"
  default     = "europe-west2-a"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image for reddit app"
  default     = "gitlab-base"
}

variable machine_type {
  description = "Machine type for app instance"
  default     = "n1-standard-1"
}

variable source_ranges {
  description = "Allowed IP addresses"
  default     = ["0.0.0.0/0"]
}

variable count {
  default = "Number of instances to create"
  default = 1
}
