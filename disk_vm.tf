resource "yandex_compute_disk" "storage_disks" {
  count = 3
  name  = "${var.vpc_name}-disk-${count.index + 1}"
  size  = 1
  zone  = var.default_zone
}

resource "yandex_compute_instance" "storage" {
  name                       = "${var.vpc_name}-storage"
  platform_id               = "standard-v1"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disks
    content {
      disk_id = secondary_disk.value.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_key_path)}"
  }

  depends_on = [yandex_compute_disk.storage_disks]
}
