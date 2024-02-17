#!/bin/bash

docker run -dit --rm --name centos7 pycontribs/centos:7 sleep 6000000
docker run -dit --rm --name ubuntu pycontribs/ubuntu:latest sleep 6000000
docker run -dit --rm --name fedora pycontribs/fedora:latest sleep 6000000

ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml --ask-vault-pass

docker stop centos7 ubuntu fedora
