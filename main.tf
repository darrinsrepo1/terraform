terraform {
  required_version = "~> 1.12.2"

  cloud {
    organization = "dscheive-homelab"

    workspaces {
      name = "homelab-prod"
    }
  }

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "4.2.0"
    }
  }
}

locals {
  environment = "prod"
}