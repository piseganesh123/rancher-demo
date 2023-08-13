resource "rancher2_cluster_v2" "learner2_cluster" {
  provider = rancher2.admin
#  name               = var.learner1_cluster_name
  name               = "learner2-cluster"
  kubernetes_version = var.workload_kubernetes_version
}
resource "rancher2_cluster_v2" "learner3_cluster" {
  provider = rancher2.admin
#  name               = var.learner1_cluster_name
  name               = "learner3-cluster"
  kubernetes_version = var.workload_kubernetes_version
}
resource "rancher2_cluster_v2" "learner4_cluster" {
  provider = rancher2.admin
#  name               = var.learner1_cluster_name
  name               = "learner4-cluster"
  kubernetes_version = var.workload_kubernetes_version
}

resource "rancher2_cluster_v2" "learner5_cluster" {
  provider = rancher2.admin
#  name               = var.learner1_cluster_name
  name               = "learner5-cluster"
  kubernetes_version = var.workload_kubernetes_version
}

resource "rancher2_cluster_v2" "learner6_cluster" {
  provider = rancher2.admin
#  name               = var.learner1_cluster_name
  name               = "learner6-cluster"
  kubernetes_version = var.workload_kubernetes_version
}

resource "rancher2_cluster_v2" "learner7_cluster" {
  provider = rancher2.admin
#  name               = var.learner1_cluster_name
  name               = "learner7-cluster"
  kubernetes_version = var.workload_kubernetes_version
}

resource "rancher2_cluster_v2" "learner8_cluster" {
  provider = rancher2.admin
#  name               = var.learner1_cluster_name
  name               = "learner8-cluster"
  kubernetes_version = var.workload_kubernetes_version
}

resource "rancher2_cluster_v2" "learner9_cluster" {
  provider = rancher2.admin
#  name               = var.learner1_cluster_name
  name               = "learner9-cluster"
  kubernetes_version = var.workload_kubernetes_version
}

resource "rancher2_cluster_v2" "learner10_cluster" {
  provider = rancher2.admin
#  name               = var.learner1_cluster_name
  name               = "learner10-cluster"
  kubernetes_version = var.workload_kubernetes_version
}

resource "rancher2_cluster_v2" "learner11_cluster" {
  provider = rancher2.admin
#  name               = var.learner1_cluster_name
  name               = "learner11-cluster"
  kubernetes_version = var.workload_kubernetes_version
}

output "learner2_custom_cluster_command" {
  value       = rancher2_cluster_v2.learner2_cluster.cluster_registration_token.0.insecure_node_command
  description = "Docker command used to add a node to the learner2 cluster"
}

output "learner3_custom_cluster_command" {
  value       = rancher2_cluster_v2.learner3_cluster.cluster_registration_token.0.insecure_node_command
  description = "Docker command used to add a node to the learner2 cluster"
}

output "learner4_custom_cluster_command" {
  value       = rancher2_cluster_v2.learner4_cluster.cluster_registration_token.0.insecure_node_command
  description = "Docker command used to add a node to the learner2 cluster"
}

output "learner5_custom_cluster_command" {
  value       = rancher2_cluster_v2.learner5_cluster.cluster_registration_token.0.insecure_node_command
  description = "Docker command used to add a node to the learner2 cluster"
}

output "learner6_custom_cluster_command" {
  value       = rancher2_cluster_v2.learner6_cluster.cluster_registration_token.0.insecure_node_command
  description = "Docker command used to add a node to the learner2 cluster"
}

output "learner7_custom_cluster_command" {
  value       = rancher2_cluster_v2.learner7_cluster.cluster_registration_token.0.insecure_node_command
  description = "Docker command used to add a node to the learner2 cluster"
}

output "learner8_custom_cluster_command" {
  value       = rancher2_cluster_v2.learner8_cluster.cluster_registration_token.0.insecure_node_command
  description = "Docker command used to add a node to the learner2 cluster"
}

output "learner9_custom_cluster_command" {
  value       = rancher2_cluster_v2.learner9_cluster.cluster_registration_token.0.insecure_node_command
  description = "Docker command used to add a node to the learner2 cluster"
}

output "learner10_custom_cluster_command" {
  value       = rancher2_cluster_v2.learner10_cluster.cluster_registration_token.0.insecure_node_command
  description = "Docker command used to add a node to the learner2 cluster"
}
