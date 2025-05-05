variable "web_servers" {
  description = "Список веб-серверов"
  type = map(object({
    cores  = number
    memory = number
  }))
  default = {
    "web-1" = {
      cores  = 2
      memory = 2
    },
    "web-2" = {
      cores  = 2
      memory = 2
    }
  }
}

variable "db_servers" {
  description = "Список серверов баз данных"
  type = map(object({
    cores       = number
    memory      = number
    disk_volume = number
  }))
  default = {
    "main" = {
      cores       = 4
      memory      = 8
      disk_volume = 20
    },
    "replica" = {
      cores       = 2
      memory      = 4
      disk_volume = 10
    }
  }
}

variable "storage_disks_count" {
  description = "Количество дополнительных дисков для хранилища"
  type        = number
  default     = 3
}

variable "vpc_name" {
  description = "Имя VPC"
  type        = string
  default     = "develop"
}

variable "default_zone" {
  description = "Зона по умолчанию"
  type        = string
  default     = "ru-central1-a"
}

variable "ssh_key_path" {
  description = "Путь к публичному SSH-ключу"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "cloud_id" {
  description = "Yandex.Cloud cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex.Cloud folder ID"
  type        = string
}

variable "default_cidr" {
  description = "CIDR блок подсети"
  type        = list(string)
}
