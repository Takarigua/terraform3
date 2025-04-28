locals {
  inventory_content = templatefile("${path.module}/inventory.tftpl", {
    webservers = [
      for instance in yandex_compute_instance.web :
      {
        name        = instance.name
        external_ip = instance.network_interface[0].nat_ip_address
        fqdn        = instance.fqdn
      }
    ]
    databases = [
      for instance in yandex_compute_instance.db :
      {
        name        = instance.name
        external_ip = instance.network_interface[0].nat_ip_address
        fqdn        = instance.fqdn
      }
    ]
    storage = [
      {
        name        = yandex_compute_instance.storage.name
        external_ip = yandex_compute_instance.storage.network_interface[0].nat_ip_address
        fqdn        = yandex_compute_instance.storage.fqdn
      }
    ]
  })
}

resource "local_file" "inventory" {
  filename = "${path.module}/inventory"
  content  = local.inventory_content
}
