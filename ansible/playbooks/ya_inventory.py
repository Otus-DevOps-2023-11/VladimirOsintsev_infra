#!/usr/bin/env python

import json
import subprocess
import argparse



inventory_list = {
    "_meta": {
        "hostvars": {}
    },
    "all": {
        "hosts": [],
        "vars": {
            "ansible_connection": "ssh",
            "ansible_user": "ubuntu"
        }
    }
}


def parse_args():
    parser = argparse.ArgumentParser(description="Yandex Cloud script")
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--list', action='store_true')
    group.add_argument('--host')
    return parser.parse_args()


def list_running_hosts(inventory_list):
    list_hosts = "yc compute instance list --format=json"
    output = subprocess.check_output(list_hosts,shell=True,universal_newlines=False)
    instances = json.loads(output)
    #print(instances)
    for el in instances:
        if el['status'] == 'RUNNING':
          instance_name = el["name"]
          instance_ip = el["network_interfaces"][0]["primary_v4_address"]["one_to_one_nat"]["address"]
          instance_env = el["name"].split("-")[0]
          inventory_list["_meta"]["hostvars"][instance_name] = {
            "ansible_host": instance_ip,
            "env": instance_env
                  }
          inventory_list["all"]["hosts"].append(instance_name)
    return inventory_list

def get_host_details(host):
    list_host = "yc compute instance get --name {} --format=json".format(host)
    output = subprocess.check_output(list_host,shell=True,universal_newlines=False)
    instances = json.loads(output)
    instance_name = instances["name"]
    instance_ip = instances["network_interfaces"][0]["primary_v4_address"]["one_to_one_nat"]["address"]
    instance_env = instances["name"].split("-")[0]
    return {'ansible_host': instance_ip,
            'ansible_ssh_user': 'ubuntu',
            'env': instance_env}



args = parse_args()
if args.list:
    print(json.dumps(list_running_hosts(inventory_list), indent=4))
else:
    print(json.dumps(get_host_details(args.host), indent=4))
