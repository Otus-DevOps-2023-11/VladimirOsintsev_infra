source "yandex" "ubuntu16" {
  service_account_key_file = var.service_account_key_file
  folder_id = var.folder_id
  zone = var.zone
  subnet_id = var.subnet_id
  use_ipv4_nat = var.use_ipv4_nat
  source_image_id = "fd879gcpkh3du0mkg78h"
#  source_image_family = "reddit-base-08-28-2023"
  image_name = "reddit-full-${formatdate("MM-DD-YYYY", timestamp())}"
  image_family = "reddit-base"
  ssh_username = var.ssh_username
  platform_id = var.platform_id
}

build {
  sources = ["source.yandex.ubuntu16"]

# provisioner "shell" {
#    inline = [
#      "echo set debconf to Noninteractive",
#      "echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections" ]
#  }

 provisioner "shell" {
    name            = "ruby"
    script          = "scripts/shutdown-apt-services.sh"
  }


  provisioner "shell" {
    name            = "reddit full"
    script          = "scripts/install_redditfull.sh"
    execute_command = "sudo {{.Path}}"
  }

 provisioner "shell" {
    name            = "enables_apt"
    inline          = [ "sudo systemctl enable apt-daily.timer",
                        "sudo systemctl enable apt-daily-upgrade.timer"
                    ]
  }

}
