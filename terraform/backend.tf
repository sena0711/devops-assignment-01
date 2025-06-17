terraform {
  cloud {
    organization = "tf-assignment-sena-01"

    workspaces {
      name = "devops-assignment-01"
    }
  }

  required_version = ">= 1.1.2"
}
