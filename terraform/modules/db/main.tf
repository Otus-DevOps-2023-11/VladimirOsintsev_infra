terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_compute_instance" "db" {
  name  = "${var.env}-reddit-db"
  labels = {
    tags = "${var.env}-reddit-db"
  }
  zone  = var.zone
 # count = var.counts
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
#  provisioner "remote-exec" {
#    script = "${path.module}/mongod.sh"
#  }
   provisioner "file" {
     source      = "${path.module}/mongod.sh"
     destination = "/tmp/mongod.sh"
   }

   provisioner "remote-exec" {
     inline = concat(["echo Provisioning"], [for command in ["chmod u+x /tmp/mongod.sh", "/tmp/mongod.sh"]: command if var.provision])
  }

  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашнем задании
      image_id = var.db_disk_image
    }
  }
  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = var.subnet_id
    nat       = true
  }
}
