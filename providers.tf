terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.61.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.15.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
}
