output "rancher_server_url" {
  value = module.rancher_common.rancher_url
}

output "rancher_node_ip" {
  value = google_compute_instance.rancher_server.network_interface.0.access_config.0.nat_ip
}

output "learner-1_node_ip" {
  value = google_compute_instance.learner-1_node.network_interface.0.access_config.0.nat_ip
}
