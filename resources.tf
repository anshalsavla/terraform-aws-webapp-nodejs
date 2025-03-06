terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.89"
    }
     github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }

}

provider "aws" {
  region  = "us-west-2"
}

