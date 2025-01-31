# 08-ansible-01-base

![Ansible Version](./pictures/ansible_version.png)
## Основная часть

### 1.

 ![Stage1](./pictures/Stage1.png)
### 2.

 ![Stage2](./pictures/Stage2.png)
### 3.

Подготавливаем образы контейнеры:

``` bash
docker pull rcarmo/ubuntu-python:3.8-onbuild-amd64
docker pull centos/python-36-centos7:latest
```

Запускаем контейнеры для ./inventory/prod.yml:

``` bash
docker run -d --rm --name ubuntu -it rcarmo/ubuntu-python:3.8-onbuild-amd64 /bin/bash
docker run -d --rm --name centos7 -it centos/python-36-centos7:latest /bin/bash
```

Проверяем:

``` bash
docker ps
```

![Stage3_docker_ps](./pictures/Stage3_docker_ps.png)
### 4.

``` bash
ansible-playbook -i inventory/prod.yml site.yml
```
![Stage3_ansible_playbook](./pictures/Stage3_Ansible_playbook.png)
### 5,6.

![Stage5_6](./pictures/Stage5_6.png)
### 7.

![Stage7](./pictures/Stage7.png)
### 8.

``` bash
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
```
![Stage8](./pictures/Stage8.png)
### 9.

``` bash
ansible-doc --type connection --list
```
![Stage9](./pictures/Stage9.png)
Для работы на control node подходит local
### 10.

prod.yml:
``` yml
---
  el:
    hosts:
      centos7:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker
  local:
    hosts:
      localhost:
        ansible_connection: local
```

### 11.

``` bash
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
```
![Stage11](./pictures/Stage11.png)

## Необязательная часть
### 1.

![StageAdd1](./pictures/StageAdd1.png)
### 2.

``` bash
ansible-vault encrypt_string
```
![StageAdd2](./pictures/StageAdd2.png)
### 3.

``` bash
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
```
![StageAdd3](./pictures/StageAdd3.png)
### 4.

Подготавливаем образ контейнера:

``` bash
docker pull pycontribs/fedora
```

Запускаем контейнер:

``` bash
docker run -d --rm --name fedora -it pycontribs/fedora:latest /bin/bash
```

Смотрим переменные:

``` bash
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
```
![StageAdd4](./pictures/StageAdd4.png)


