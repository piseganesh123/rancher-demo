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




