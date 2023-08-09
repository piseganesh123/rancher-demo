resource "rancher2_cluster_v2" "learner2_cluster" {
  provider = rancher2.admin

  name               = var.learner_2_cluster_name
  kubernetes_version = var.workload_kubernetes_version
}