terraform {
  required_version = "~> 1.12.2"

#  backend "s3" {
#    # Backend-specific configuration
#    bucket = "prd-terraform-state"
#    key = "prod/terraform.tfstate"
#    region = "us-west-1"
#    use_lockfile = true
#  }

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "4.2.0"
    }
  }
}