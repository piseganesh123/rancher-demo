# GCP infrastructure resources

# GCP Public Compute Address for quickstart node
resource "google_compute_address" "learner1_node_address" {
  count = 2
  name = format("%s%s","node-ipv4-address",(count.index+2))
  address_type = "EXTERNAL"
}

# GCP compute instance for creating a single node workload cluster
resource "google_compute_instance" "learner1_node"{ #"quickstart_node"
  depends_on = [
    google_compute_firewall.rancher_fw_allowall,
  ]
  count = 2
  scheduling {
    preemptible = "true"
    provisioning_model = "SPOT"
    automatic_restart = "false"
  }
  
  name         = format("%s%s","${var.prefix}-learner", (count.index+2))
  #machine_type = var.machine_type
  machine_type = "e2-small"
  zone         = var.gcp_zone

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-jammy-v20230727"
      size = "15"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.learner1_node_address.address
    }
  }

  metadata = {
    ssh-keys       = "${local.node_username}:${tls_private_key.global_key.public_key_openssh}"
    enable-oslogin = "FALSE"
  }

#  metadata_startup_script = templatefile(
#    "${path.module}/files/userdata_quickstart_node.template",
#    {
#      register_command = module.rancher_common.learner_one_cluster_command #custom_cluster_command
#      public_ip        = google_compute_address.learner1_node_address.address
#      public_ip        = self.public_ip
#    }
#  )

  provisioner "remote-exec" {
    inline = [
      "echo 'SSH connection worked'",
    ]

    connection {
      type        = "ssh"
      host        = self.network_interface.0.access_config.0.nat_ip
#      host        = self.public_ip
      user        = local.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }
}
