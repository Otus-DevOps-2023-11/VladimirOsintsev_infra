terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_compute_instance" "app" {
  name  = "${var.env}-reddit-app"
  labels = {
    tags = "${var.env}-reddit-app"
  }
  zone  = var.zone
#  count = (var.provision == true ? 1 : 0)
  allow_stopping_for_update = true
  resources {
    cores  = 2
    memory = 2
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
  connection {
    type  = "ssh"
    host  = self.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }
  provisioner "file" {
    source      = "${path.module}/puma.service"
    destination = "/tmp/puma.service"
  }
  provisioner "file" {
    source      = "${path.module}/deploy.sh"
    destination = "/tmp/deploy.sh"
  }
  provisioner "remote-exec" {
    inline = concat(["echo Provisioning"], [for command in ["chmod u+x /tmp/deploy.sh", "/tmp/deploy.sh ${var.db_ip}"]: command if var.provision])
  }
  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашнем задании
      image_id = var.app_disk_image
    }
  }
  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = var.subnet_id
    nat       = true
  }
}
