#!/bin/bash

docker run -d --rm --name ubuntu -it rcarmo/ubuntu-python:3.8-onbuild-amd64 /bin/bash
docker run -d --rm --name centos7 -it centos/python-36-centos7:latest /bin/bash
docker run -d --rm --name fedora -it pycontribs/fedora:latest /bin/bash

ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass

docker stop fedora
docker stop centos7
docker stop ubuntu