provider "aws" {
  profile                 = "linuxtips-terraform"
  shared_credentials_file = "~/.aws/credentials"
  region                  = "us-east-1"
}

provider "aws" {
  alias                   = "west"
  region                  = "us-west-2"
  profile                 = "linuxtips-terraform"
  shared_credentials_file = "~/.aws/credentials"
}

terraform {
  backend "s3" {
    profile = "linuxtips-terraform"
    bucket  = "descomplicando-terraform-fabio-bartoli"
    key     = "terraform-test.tfstate"
    region  = "us-east-1"
    encrypt = true
  }

  required_providers {
    aws = {
      version = "~> 3.0"
      source  = "hashicorp/aws"
    }
  }
}