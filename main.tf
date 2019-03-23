provider "google" {
  region = "${var.region}"
  credentials = "${file("${var.credentials_file_path}")}"
}

resource "google_compute_network" "network" {
  name = "vpc1"
  auto_create_subnetworks = "true"
  project = "${var.project_name}"
}

# Allow the hosted network to be hit over ICMP, SSH, and HTTP.
resource "google_compute_firewall" "network" {
  name    = "allow-ssh-and-icmp"
  network = "${google_compute_network.network.self_link}"
  project = "${var.project_name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
}

resource "google_compute_instance" "instance" {
  name = "linux2"
  project = "${var.project_name}"
  machine_type = "f1-micro"
  zone = "${var.region_zone}"
    boot_disk {
        initialize_params {
            image = "projects/debian-cloud/global/images/family/debian-9"
        }
    }
    metadata {
        startup-script = "${file("install-vm.sh")}"
    }
    network_interface {
        network = "${google_compute_firewall.network.network}"
        access_config {
            //ephemeral IP
        }
    }
}