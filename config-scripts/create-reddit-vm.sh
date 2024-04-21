yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-id="fd8l4aaf7c33i5h8mfii",size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --zone ru-central1-a \
  --ssh-key ~/.ssh/appuser.pub
