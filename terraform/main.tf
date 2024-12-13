variable "project_id" {
  type        = string
  description = "Your Scaleway project ID."
}

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
}

provider "scaleway" {
  zone   = "pl-waw-2"
  region = "pl-waw"
}

resource "scaleway_instance_ip" "public_ip" {
  project_id = var.project_id
}

resource "scaleway_instance_volume" "data" {
  project_id = var.project_id
  size_in_gb = 10
  type       = "b_ssd"
}

resource "scaleway_instance_server" "web" {
  project_id = var.project_id
  type       = "STARDUST1-S"
  image      = "ubuntu_noble"

  name = "supabase-deployment-testing"

  tags = ["tests"]

  ip_id = scaleway_instance_ip.public_ip.id

  additional_volume_ids = [scaleway_instance_volume.data.id]

  root_volume {
    size_in_gb = 10
  }
}

