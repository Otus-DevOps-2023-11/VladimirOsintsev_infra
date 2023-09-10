variable "cloud_id" {
  description = "Cloud"
  default     = ""
}
variable "folder_id" {
  description = "Folder"
  default     = "b1g3v5m91gs0aigtbmgm"
}
variable "zone" {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable "zone_instance" {
  default = ""
}
variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
  default     = "~/.ssh/appuser.pub"
}
variable "private_key_path" {
  description = "Path to the private key"
  default     = "~/.ssh/appuser"
}
variable "image_id" {
  description = "Disk image"
  default     = "fd879gcpkh3du0mkg78h"
}
variable "subnet_id" {
  description = "Subnet"
  default     = "e9bka0dq4rcen4gjipat"
}
variable "service_account_key_file" {
  default = "key-terraform.json"
}

variable "counts" {
  description = "Count instance"
  default     = 1
}
