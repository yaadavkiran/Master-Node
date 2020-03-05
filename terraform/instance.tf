resource "google_compute_instance" "master" {

  count = "${length(var.vm_master)}"
  name         = "${element(var.vm_master,count.index)}"
  machine_type = "n1-standard-2"
  zone         = "${var.region}-a"

tags = ["k8s", "master"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7-v20200205"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    name = "nginx"
    ssh-keys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }

 #metadata_startup_script = "${file("startup.sh")}"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

resource "google_compute_instance" "worker" {
  count = "${length(var.vm_worker)}"
  name         = "${element(var.vm_worker,count.index)}"
  machine_type = "n1-standard-1"
  zone         = "${var.region}-a"

tags = ["k8s", "worker"]

boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7-v20200205"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    name = "nginx"
    ssh-keys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }

 #metadata_startup_script = "${file("startup.sh")}"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}
