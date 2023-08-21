# VladimirOsintsev_infra

1) Исследовать способ подключения к someinternalhost в одну команду:
Выполняем команду для проброса портов:
ssh -i ~/.ssh/appuser -L 2222:10.128.0.3:22 appuser@51.250.14.38
где 51.250.14.38 - внешний адрес bastion-хоста
10.128.0.3 - внутреннний адрес someinternalhost
подключаемся с помощью одной команды:
ssh -i ~/.ssh/appuser -p 2222 appuser@localhost

Дополнительное задание:
Предложить вариант решения для подключения из консоли при помощи команды
вида ssh someinternalhost
C помощью SSH Config File ~/.ssh/config

Host someinternalhost
    HostName localhost
    User appuser
    Port 2222
    IdentityFile ~/.ssh/appuser


OpenVPN:

bastion_IP = 51.250.14.38
someinternalhost_IP = 10.128.0.3


Дополнительное задание:
OpenVPN:
LetensCrypt в логах выдал что есть лимиты на домен nip.io
Response Code: 429
Response: {
  "type": "urn:ietf:params:acme:error:rateLimited",
  "detail": "Error creating new order :: too many certificates already issued for \"nip.io\". Retry after 2023-08-21T02:00:00Z: see https://letsencrypt.org/docs/rate-limits/",
  "status": 429
}
  acme_domain = "51-250-14-38.nip.io"

Но удалось выпустить сертификаты  https://51-250-14-38.sslip.io/
