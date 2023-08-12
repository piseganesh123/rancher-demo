#variable learner_2_cluster_name {
#  type        = string
#  description = "Name for created learning cluster"
#}

# Required
variable "rancher_server_dns" {
  type        = string
  description = "DNS host name of the Rancher server"
}