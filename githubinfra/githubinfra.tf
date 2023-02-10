terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "5.17.0"
    }
  }
}

provider "github" {
  # Configuration options
  token = "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"  
}


resource "github_repository" "terra_test" {
  name        = "terraform_test"
  description = "Test rpo"
  private = true
}
