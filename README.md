

Создана новая ветка

Установлен вагрант через  пакетный менеджер

Установлен virtual box

В Vagrantfile добавлена строка для скачивания образов

 ENV['VAGRANT_SERVER_URL'] = 'https://vagrant.elab.pro'

 vagrant init
 vagrant up
 vagrant box list
 vagrant status
 vagrant ssh 'server_name'
 vagrant destroy -f

Добавлена роль ансибла

 vagrant provision 'server_name'

Доработаны роли

Просмотрен инвентори вагранта

 cat .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory

Установлен molecule. Для ансибла 6.7 (core 2.13.13). molecule_vagrant 2.0.0

 python3 -m pip install --user molecule==3.5.1

 molecule init scenario default -r db -d vagrant
 molecule create
 molecule list
 molecule login -h instance

Для моей версии molecule меняем плейбук converge.yml и прогоняем тесты

 molecule converge
 molecule verify

Добавлена проверка порта

 def test_mongo_port(host):
 assert host.socket('tcp://0.0.0.0:27017').is_listening

Скопированы конфиги и измененый плейбуки пакера (добавлены роли)

Изменены конфиги пакера
