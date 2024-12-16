output "server_ip_address" {
    value = "${scaleway_instance_ip.public_ip.address}"
}

terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    bucket                      = "homeopath-terraform-states"
    key                         = "homeopath-supabase.tfstate"
    region                      = "fr-par"
    endpoints = {
      s3 = "https://s3.fr-par.scw.cloud"
    }
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
  }
}

provider "scaleway" {
  zone   = "fr-par-1"
  region = "fr-par"

  access_key = var.scw_access_key
  secret_key = var.scw_secret_key

  project_id = var.project_id
}

resource "scaleway_instance_ip" "public_ip" {
  project_id = var.project_id
}

resource "scaleway_instance_server" "web" {
  project_id = var.project_id
  type       = "DEV1-M"
  image      = "ubuntu_noble"

  name = "supabase"

  tags = []

  ip_id = scaleway_instance_ip.public_ip.id

  additional_volume_ids = []

  root_volume {
    size_in_gb = 30
  }
}

