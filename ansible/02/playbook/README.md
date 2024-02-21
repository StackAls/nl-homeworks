# Ansible Clickhouse + Vector

This ansible playbook install Clickhouse and Vector

## Variables

[Version Clickhouse](https://packages.clickhouse.com/rpm/stable/)
[Version Vector](https://packages.timber.io/vector/)

```bash
# clickhouse version 
clickhouse_version: "22.3.7.28"
# vector major version 
vector_versionm: "0.36.0"
# vector version 
vector_version: "0.36.0-1"
```

Refer the file [Config templates for Vector](./templates/vector.j2) to change the config values.

## Install

Change inventory and your ssh private key

```bash
ansible-playbook --private-key ~/.ssh/nl-ya-ed25519 -i inventory/prod.yml site.yml
```
