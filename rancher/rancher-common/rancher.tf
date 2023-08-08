# Rancher resources

# Initialize Rancher server
resource "rancher2_bootstrap" "admin" {
  depends_on = [
    helm_release.rancher_server
  ]

  provider = rancher2.bootstrap

  password  = var.admin_password
  telemetry = true
}

# Create custom managed cluster for quickstart
resource "rancher2_cluster_v2" "quickstart_workload" {
  provider = rancher2.admin

  name               = var.workload_cluster_name
  kubernetes_version = var.workload_kubernetes_version
}
# Create custom managed cluster for quickstart

resource "rancher2_cluster_v2" "learner1_cluster" {
  provider = rancher2.admin

  name               = var.learner_one_cluster_name
  kubernetes_version = var.workload_kubernetes_version
}

# Create second learner node
resource "rancher2_cluster_v2" "learner2_node" {
  provider = rancher2.admin

  name               = "l2cluster"
  kubernetes_version = var.workload_kubernetes_version
}