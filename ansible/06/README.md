# Домашнее задание к занятию 6 «Создание собственных модулей»

```bash
git clone https://github.com/ansible/ansible.git
cd ansible
python3 -m venv venv
. venv/bin/activate
pip install -r requirements.txt
. hacking/env-setup
deactivate
. venv/bin/activate && . hacking/env-setup

python3 -m ansible.modules.my_own_module payload.json
#screen
ansible-playbook site.yml
#screen
ansible-galaxy collection init my_own_namespace.yandex_cloud_elk
mkdir my_own_namespace/yandex_cloud_elk/plugins/modules
cp ../ansible/lib/ansible/modules/my_own_module.py my_own_namespace/yandex_cloud_elk/plugins/modules
cd my_own_namespace/yandex_cloud_elk

cd roles
ansible-galaxy role init my_own_module
ansible-galaxy collection build
ansible-galaxy collection install module/my_own_namespace-yandex_cloud_elk-1.0.0.tar.gz

ansible-doc -l | grep my_own

```

[code module](./module/)

[galaxy collection](./my_own_namespace/yandex_cloud_elk/)

[playbook](./playbook/)

![screen](./screen/Screenshot2024-03-10-203001.png)
![screen](./screen/Screenshot2024-03-10-210836.png)
![screen](./screen/Screenshot2024-03-10-221724.png)
