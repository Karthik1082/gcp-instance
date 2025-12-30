resource "google_compute_instance" "myvm" {
  machine_type = "e2-micro"
  zone = "us-central1-a"
  count = 3
  name = "my-vm-${count.index}"


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {
      
    }
  }



  service_account {
    email = google_service_account.default.email
    scopes = [ "cloud-platform" ]
  }



}

resource "google_service_account" "default" {
  account_id   = "my-custom-sa"
  display_name = "Custom SA for VM Instance"
}

output "vm_ip" {
  value = google_compute_instance.myvm[*].network_interface[0].access_config[0].nat_ip
 
}
