# GCP infrastructure resources

resource "tls_private_key" "global_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_sensitive_file" "ssh_private_key_pem" {
  filename        = "${path.module}/id_rsa_${formatdate("MM-DD", timestamp())}"
  content         = tls_private_key.global_key.private_key_pem
  file_permission = "0600"
}

resource "local_file" "ssh_public_key_openssh" {
  filename = "${path.module}/id_rsa.pub"
  content  = tls_private_key.global_key.public_key_openssh
}

# GCP Public Compute Address for rancher server node
resource "google_compute_address" "rancher_server_address" {
  name = "rancher-server-ipv4-address"
}

# Firewall Rule to allow all traffic
resource "google_compute_firewall" "rancher_fw_allowall" {
  name    = "${var.prefix}-rancher-allowall"
  network = "default"

  allow {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]
}

# GCP Compute Instance for creating a single node RKE cluster and installing the Rancher server
resource "google_compute_instance" "rancher_server" {
  depends_on = [
    google_compute_firewall.rancher_fw_allowall,
  ]

  scheduling {
    preemptible = "true"
    provisioning_model = "SPOT"
    automatic_restart = "false"
  }
  
  name         = "${var.prefix}-rancher-server"
  machine_type = var.machine_type
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
      nat_ip = google_compute_address.rancher_server_address.address
    }
  }

  metadata = {
    ssh-keys       = "${local.node_username}:${tls_private_key.global_key.public_key_openssh}"
    enable-oslogin = "FALSE"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'SSH connection worked'",
    ]

    connection {
      type        = "ssh"
      host        = self.network_interface.0.access_config.0.nat_ip
      user        = local.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }
}

# Rancher resources
module "rancher_common" {
  source = "../rancher-common"

  node_public_ip             = google_compute_instance.rancher_server.network_interface.0.access_config.0.nat_ip
  node_internal_ip           = google_compute_instance.rancher_server.network_interface.0.network_ip
  node_username              = local.node_username
  ssh_private_key_pem        = tls_private_key.global_key.private_key_pem
  rancher_kubernetes_version = var.rancher_kubernetes_version

  cert_manager_version    = var.cert_manager_version
  rancher_version         = var.rancher_version
  rancher_helm_repository = var.rancher_helm_repository

  rancher_server_dns = join(".", ["rancher", google_compute_instance.rancher_server.network_interface.0.access_config.0.nat_ip, "sslip.io"])
  admin_password     = var.rancher_server_admin_password

  workload_kubernetes_version = var.workload_kubernetes_version

 #worker node names 
  workload_cluster_name       = "quickstart-gcp-custom"
  learner1_cluster_name       = "learner1-cluster"
}