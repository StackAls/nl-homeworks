# Домашняя работа к занятию 2 «Работа с Playbook»

## Основная часть

Подготовлены tasks для установки clickhouse и vector [code](./playbook/site.yml)

```bash
# для ansible-lint необходим python3.9
sudo apt install python3.9
source ~/.venv/bin/activate
pip install ansible-lint
ansible-lint site.yml
```

Исправил ошибки.
![screen](./screen/Screenshot2024-02-21-174908.png)

```bash
ansible-playbook --private-key ~/.ssh/nl-ya-ed25519 -i inventory/prod.yml site.yml --check
```

![screen](./screen/Screenshot2024-02-21-175239.png)

```bash
ansible-playbook --private-key ~/.ssh/nl-ya-ed25519 -i inventory/prod.yml site.yml --diff
```

![screen](./screen/Screenshot2024-02-21-225653.png)
![screen](./screen/Screenshot2024-02-21-231353.png)

```bash
ansible-playbook --private-key ~/.ssh/nl-ya-ed25519 -i inventory/prod.yml site.yml --diff
```

![screen](./screen/Screenshot2024-02-21-232459.png)

[README.md-файл по playbook](./playbook/README.md).
