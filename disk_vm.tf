# Используем переменную для образа
data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts" # Актуальный образ
}

# Создаем 3 диска с уникальными именами
resource "yandex_compute_disk" "storage_disks" {
  count    = 3
  name     = "${var.vpc_name}-disk-${count.index + 1}"
  size     = 1 # 1 ГБ
  zone     = var.default_zone
}

# ВМ Storage с динамическим подключением дисков
resource "yandex_compute_instance" "storage" {
  name        = "${var.vpc_name}-storage"
  platform_id = "standard-v1"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id # Используем data source
    }
  }

  # Динамическое подключение дисков
  dynamic "secondary_disk" {
    for_each = { for k, v in yandex_compute_disk.storage_disks : k => v }
    content {
      disk_id = secondary_disk.value.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id # Используем существующую подсеть
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_key_path)}"
  }

  depends_on = [yandex_compute_disk.storage_disks]
}