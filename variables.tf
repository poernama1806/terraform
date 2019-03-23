variable "region" {
  default = "us-central1"
}

variable "region_zone" {
  default = "us-central1-f"
}

variable "project_name" {
  default = "project1-2019-234412"
}

variable "org_id" {
  default = "0069E0-304A0E-95E1AF"
}

variable "billing_account_id" {
  default = "0069E0-304A0E-95E1AF"
}

variable "credentials_file_path" {
  description = "Location of the credentials to use."
  default     = "~/Documents/Github/terraform-instance1/project1-key.json"
}
