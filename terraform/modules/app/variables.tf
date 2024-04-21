variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable private_key_path {
  description = "Path to the private key used for ssh access"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default = "reddit-app-base"
}
variable subnet_id {
  description = "Subnets for modules"
}

variable zone {
  description = "Zone for modules"
}
variable env {
  description = "Enviroment env"
}
variable db_ip {
  description = "IP-adresess MongoDB"
}
variable "provision" {
  description = "Disable/Enable Provisioning"
}
