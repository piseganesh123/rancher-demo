# GCP infrastructure resources

resource "tls_private_key" "global_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_sensitive_file" "ssh_private_key_pem" {
  filename        = "${path.module}/id_rsa"
  content         = tls_private_key.global_key.private_key_pem
  file_permission = "0600"
}

resource "local_file" "ssh_public_key_openssh" {
  filename = "${path.module}/id_rsa.pub"
  content  = tls_private_key.global_key.public_key_openssh
}

# GCP Public Compute Address for quickstart node
resource "google_compute_address" "learner2_node_address" {
#  count = 2
#  name = format("%s%s","node-ipv4-address",(count.index+2))
  name = "learner1-node-ipv4-address"
  address_type = "EXTERNAL"
}

# GCP compute instance for creating a single node workload cluster
resource "google_compute_instance" "learner2_node"{ #"quickstart_node"
#  depends_on = [
#    google_compute_firewall.rancher_fw_allowall,
#  ]
#  count = 2
  scheduling {
    preemptible = "true"
    provisioning_model = "SPOT"
    automatic_restart = "false"
  }
  
#  name         = format("%s%s","${var.prefix}-learner", (count.index+2))
  name         = "${var.prefix}-learner2-node"
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
      nat_ip = google_compute_address.learner2_node_address.address
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
