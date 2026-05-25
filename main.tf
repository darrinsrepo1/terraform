terraform {
  required_version = "~> 1.12.2"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "4.2.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "~> 3.3.0"
    }
  }
}