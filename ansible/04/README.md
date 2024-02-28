# Домашняя работа к занятию 4 «Работа с roles»

```bash
ssh-agent bash
ssh-add ~/.ssh/nl-ya-ed25519
# add ~/.ssh/nl-ya-ed25519.pub to GitHub key
# https://github.com/settings/keys

# python 3.9 for ansible-lint
python3.9 -m venv ~/.venv
source ~/.venv/bin/activate
pip3 install ansible-lint

ansible-galaxy role init vector-role 
# ansible-galaxy role init lighthouse-role
cd vector-role
# cd lighthouse-role
git init
git add -A
git status
git commit -m 'Init project'
git branch -M main
git remote add origin git@github.com:StackAls/vector-role.git
# git remote add origin git@github.com:StackAls/lighthouse-role.git
git push -u origin main
git tag 1.0
git push origin --tags

cd playbook
ansible-galaxy install -r requirements.yml -p ./roles
ansible-lint site.yml
ansible-playbook -i inventory/prod.yml site.yml
```

## Основная часть

- [GitHub vector-role repo](https://github.com/StackAls/vector-role)
- [GitHub lighthouse-role repo](https://github.com/StackAls/lighthouse-role)
- [GitHub playbook repo](https://github.com/StackAls/nl-homeworks/tree/main/ansible/04)
