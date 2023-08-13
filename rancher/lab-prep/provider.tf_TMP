terraform {
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = "3.0.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "4.24.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }    
  }
  required_version = ">= 1.0.0"
}

# Rancher2 bootstrapping provider
provider "rancher2" {
  alias = "bootstrap"

  api_url  = "https://${var.rancher_server_dns}"
  insecure = true
  # ca_certs  = data.kubernetes_secret.rancher_cert.data["ca.crt"]
  bootstrap = true
}

# Rancher2 administration provider
provider "rancher2" {
  alias = "admin"

  api_url  = "https://${var.rancher_server_dns}"
  insecure = true
  # ca_certs  = data.kubernetes_secret.rancher_cert.data["ca.crt"]
  token_key = rancher2_bootstrap.admin.token
  timeout   = "300s"
}

provider "google" {
  credentials = file(var.gcp_account_json)
  project     = var.gcp_project
  region      = var.gcp_region
  zone        = var.gcp_zone
}
