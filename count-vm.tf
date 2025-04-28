locals {
  ssh_key = file("~/.ssh/id_rsa.pub")
}

resource "yandex_compute_instance" "web" {
  count = 2
  name = "web-${count.index + 1}"
  
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd85b6k7esmsatsjb6fr"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_key_path)}"
  }

  depends_on = [yandex_compute_instance.db]
}
