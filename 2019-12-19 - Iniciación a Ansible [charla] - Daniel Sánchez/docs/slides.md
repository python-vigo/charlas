% Iniciación a Ansible
% Daniel Sánchez
% 2019-12-19

## ![](./figures/logo.svg){height=5%}

* **Web**: https://www.ansible.com/
* **Repositorio**: https://github.com/ansible/ansible
* **Documentación**: https://docs.ansible.com/ansible
* **AWX** (Tower): https://github.com/ansible/awx

::: notes

* Red Hat
* Libre
* Tower

:::

## Devops

Principios, CAMS:

* Culture
* **Automation**
* Measurement
* Sharing

::: notes

Contexto
Principios
Agile => Devops

:::

## Configuración como código

Ventajas:

::: incremental

* Idempotente
* Versionable
* Testeable

:::
::: notes

* Repetible
* git
* molecule

:::

## Características

::: incremental

* Legible: Secuencia de comandos básicos
* Clientes sin agentes. Requisitos:
  * Python >= 2.6
  * Acceso SSH (preferiblemente clave pública)
* Conexión ssh/winrm en paralelo
* No necesita usuario root (permite la utilización de sudo)
* Separa:
  * Programación: Playbooks, roles
  * Parametrización: Inventario

:::

::: notes

docker chroot kubectl oc vmware_tools ...

:::

## Escrito en... *Yaml*

~~~ yaml
---
esto_es: un diccionario
clave: valor
diccionario_anidado:
  # El indentado define el anidamiento
  numero: 42
  boolean: True
  nulo:
  string: Una cadena de texto
  lista:
    - Javascript es subconjunto de yaml
    - [ "lista anidada", "estilo javascript" ]
    - "Entrecomilla strings con simbolos del yaml. Ejemplo :{}[] "
"sigue el diccionario": Cuidado con las claves con espacios
multilinea: >
  Mayor > si queremos que esté todo en una
  línea o pipe | para conservar enters ...
foo: bar
~~~

## Instalación

~~~ bash
python -m pip install --user --upgrade ansible
~~~

~~~ bash
dnf install ansible
# apt install ansible
~~~

## Inventario - Hosts

inventory.yml

~~~ yaml
all:
  hosts:
    server_1:
    server_2:
    # ...
    server_n:
~~~

## Ejecución simple
~~~ bash
ansible -m ping -i inventory.yml all
~~~
[💻](./figures/inventory_hosts_ping.svg)

<object data="./figures/inventory_hosts_ping.svg" type="image/svg+xml">
😱 Oops, inaccesible la grabación de termtosvg 😕
</object>


## Inventario - Variables

~~~ yaml
all:
  vars:
    una_variable: la misma para todos
  hosts:
    server_1:
    server_2:
    # ...
    server_n:
~~~

## Playbook - Variables

main.yml

~~~ yaml
---
- hosts: all
  tasks:

    - name: Imprime mensaje con variable
      debug:
        msg: "{{ una_variable | upper }}"
~~~
::: notes

Playbook
Setup
Filtros

:::

## Ejecución playbook

~~~ bash
ansible-playbook -i inventory.yml main.yml
~~~
[💻](./figures/playbook_debug.svg)

<object data="./figures/playbook_debug.svg" type="image/svg+xml">
😱 Oops, inaccesible la grabación de termtosvg 😕
</object>

## Inventario - Grupos

~~~ yaml
all:
  vars:
    una_variable: para todos
  hosts:
    localhost:
      ansible_connection: local
      ansible_python_interpreter: "/usr/bin/env python"
  children:
    raspis:
      hosts:
        raspberrypi_1:
          ansible_host: 192.168.0.25
          ansible_python_interpreter: /usr/bin/python
          ansible_user: pi
~~~

## Módulo Setup

~~~ bash
script raspberrypi_1_setup.log
ansible -m setup -i inventory.yml raspberrypi_1
exit
less -R raspberrypi_1_setup.log
~~~

## Módulo Setup

~~~ bash
ansible -m setup -i inventory.yml raspberrypi_1
~~~

[💻](./figures/setup_raspbery.svg)

<object data="./figures/setup_raspbery.svg" type="image/svg+xml">
😱 Oops, inaccesible la grabación de termtosvg 😕
</object>

## Modulos

* Cloud modules
* Clustering modules
* Commands modules
* Crypto modules
* Database modules
* Files modules
* Identity modules
* Inventory modules
* Messaging modules
* Monitoring modules
* Net Tools modules
* Network modules
* Notification modules
* Packaging modules
* Remote Management modules
* Source Control modules
* Storage modules
* System modules
* Utilities modules
* Web Infrastructure modules
* Windows modules

## Playbook - register

~~~ bash
---
- hosts: raspberrypi_1
  tasks:

    - name: Recupera hostname
      shell: hostname
      register: hostname_result
    - debug:
        var: hostname_result
~~~

## Inventario - vault
~~~ bash
ansible-vault encrypt_string --vault-id dev@prompt
~~~
~~~
New vault password (dev):
Confirm new vault password (dev):
Reading plaintext input from stdin. (ctrl-d to end input)
clave_secreta!vault |
$ANSIBLE_VAULT;1.2;AES256;dev
37376130313137353234396666333136656330343430313230323463633661336439663339613639
3133306431383738316362373939343833326437336233320a636234303163313266656331393964
32313433633064613632363533666435373038643137396265646361633932623862663864643636
3764383262633564310a333166313437353337613430656461656136303338363234613131313730
3530
~~~

## Inventario - vault
~~~ yaml
all:
  children:
    raspis:
      hosts:
        raspberrypi_1:
          ansible_host: 192.168.0.25
          ansible_python_interpreter: /usr/bin/python
          ansible_user: pi
          wifi_ssid: casa
          wifi_password: !vault |
            $ANSIBLE_VAULT;1.2;AES256;dev
            37376130313137353234396666333136656330343430313230323463633661336439663339613639
            3133306431383738316362373939343833326437336233320a636234303163313266656331393964
            32313433633064613632363533666435373038643137396265646361633932623862663864643636
            3764383262633564310a333166313437353337613430656461656136303338363234613131313730
            3530
~~~


## Playbook - vault

~~~ yaml
---
- hosts: raspberrypi_1
  tasks:

    - name: Configura wifi
      template:
        src: wpa_supplicant.conf
        dest: /etc/wpa_supplicant/wpa_supplicant.conf
        mode: 0600
        user: root
        group: root
~~~

## Template file

~~~
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=ES

network={
  ssid="{{ wifi_ssid }}"
  psk="{{ wifi_password }}"
  key_mgmt=WPA-PSK
}
~~~

## Avanzado

* Roles
* Módulos
* Filtros
* Test (Molecule)
* ...

## Credits

* **ansible** [https://pypi.org/project/ansible/](https://pypi.org/project/ansible/)
* **termtosvg** [https://pypi.org/project/termtosvg/](https://pypi.org/project/termtosvg/) - capturing terminal log colors
* **markdownreveal** [https://pypi.org/project/markdownreveal/](https://pypi.org/project/markdownreveal/) - slides
* Ansible Logo [https://commons.wikimedia.org/wiki/File:Ansible_logo.svg](https://commons.wikimedia.org/wiki/File:Ansible_logo.svg)
* [https://daniel-at-github.github.io/charla_2019-12-19__Iniciacion_a_Ansible/](https://daniel-at-github.github.io/charla_2019-12-19__Iniciacion_a_Ansible/)
