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
  name = "learner2-node-ipv4-address"
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
#  name         = "${var.prefix}-learner2-node"
  name = "learner2-node"
  #machine_type = var.machine_type
  machine_type = "e2-medium"
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
    #ssh-keys       = "${local.node_username}:${tls_private_key.global_key.public_key_openssh}"
    ssh-keys = "gcpuser:${tls_private_key.global_key.public_key_openssh}"
    enable-oslogin = "FALSE"
  }

  metadata_startup_script = templatefile(
    "${path.module}/../files/userdata_quickstart_node.template",
    {
      register_command = module.rancher_common.learner2_cluster #custom_cluster_command
      public_ip        = google_compute_address.learner2_node_address.address
    }
  )

  provisioner "remote-exec" {
    inline = [
      "echo 'SSH connection worked'",
    ]

    connection {
      type        = "ssh"
      host        = self.network_interface.0.access_config.0.nat_ip
#      host        = self.public_ip
#      user        = local.node_username
      user        = "gcpuser"
      private_key = tls_private_key.global_key.private_key_pem
#      private_key = "../gcp/id_rsa"
    }
  }
}

module "rancher_common" {
  source = "../rancher-common"

#  node_public_ip             = google_compute_instance.rancher_server.network_interface.0.access_config.0.nat_ip
#  node_internal_ip           = google_compute_instance.rancher_server.network_interface.0.network_ip
#  node_username              = local.node_username
#  ssh_private_key_pem        = tls_private_key.global_key.private_key_pem
#  rancher_kubernetes_version = var.rancher_kubernetes_version

#  cert_manager_version    = var.cert_manager_version
#  rancher_version         = var.rancher_version
#  rancher_helm_repository = var.rancher_helm_repository

  rancher_server_dns = join(".", ["rancher", google_compute_instance.rancher_server.network_interface.0.access_config.0.nat_ip, "sslip.io"])
  admin_password     = var.rancher_server_admin_password

  workload_kubernetes_version = var.workload_kubernetes_version

 #worker node names 
  workload_cluster_name       = "quickstart-gcp-custom"
  learner1_cluster_name       = "learner1-cluster"
  learner2_cluster_name       = "learner2-cluster"
}