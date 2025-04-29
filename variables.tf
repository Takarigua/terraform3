variable "web_count" {
  description = "Количество веб-серверов"
  type        = number
  default     = 2
}

variable "db_count" {
  description = "Количество серверов баз данных"
  type        = number
  default     = 2
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
