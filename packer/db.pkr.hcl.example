source "yandex" "dbbase" {
  service_account_key_file = var.service_account_key_file
  folder_id = var.folder_id
  zone = var.zone
  subnet_id = var.subnet_id
  use_ipv4_nat = var.use_ipv4_nat
  source_image_family = var.source_image_family
  image_name = "reddit-db-base"
  image_family = var.image_family
  ssh_username = var.ssh_username
  platform_id = var.platform_id
}

build {
  sources = ["source.yandex.dbbase"]

 provisioner "shell" {
    inline = [
      "echo set debconf to Noninteractive",
      "echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections" ]
  }

  provisioner "shell" {
    name            = "ruby"
    script          = "scripts/shutdown-apt-services.sh"
   }


  provisioner "shell" {
    name            = "mongodb"
    script          = "scripts/install_mongodb.sh"
    execute_command = "sudo {{.Path}}"
  }

  provisioner "shell" {
    name            = "enables_apt"
    inline          = [ "sudo systemctl enable apt-daily.timer",
                        "sudo systemctl enable apt-daily-upgrade.timer"
                    ]
  }

}
