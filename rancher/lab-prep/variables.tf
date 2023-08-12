#variable learner_2_cluster_name {
#  type        = string
#  description = "Name for created learning cluster"
#}

# Required
variable "rancher_server_dns" {
  type        = string
  description = "DNS host name of the Rancher server"
}

variable "gcp_account_json" {
  type        = string
  description = "File path and name of service account access token file."
  default     = "us-east4"

}

variable "gcp_project" {
  type        = string
  description = "GCP project in which the quickstart will be deployed."
}

variable "gcp_region" {
  type        = string
  description = "GCP region used for all resources."
  default     = "us-east4"
}

variable "gcp_zone" {
  type        = string
  description = "GCP zone used for all resources."
  default     = "us-east4-a"
}