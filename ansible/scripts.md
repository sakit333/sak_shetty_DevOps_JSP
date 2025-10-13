# Ansible Scripts
---
1. **Target Sections**
```yml
---
- name: check with targets
  hosts: dev
  user: ansible
  become: yes
  connection: ssh
  gather_facts: no
```
---
2. **Tasks Section using command**
```yml
---
- name: check with targets
  hosts: dev
  user: ansible
  become: yes
  connection: ssh
  gather_facts: no
  tasks:
    - name: ubuntu update
      command: apt update -y
    - name: install apache2
      shell: apt install apache2 -y
```
---
3. **Tasks section using apt module**
```yml
---
- name: check with targets
  hosts: dev
  user: ansible
  become: yes
  connection: ssh
  gather_facts: no
  tasks:
    - name: install apache2
      apt:
        name: apache2
        state: present
    - name: start the service
      service:
        name: apache2
        state: started
```
---
4. **Tasks sections with update and install nginx**
```yml
---
- name: check with targets
  hosts: dev
  user: ansible
  become: yes
  connection: ssh
  gather_facts: no
  tasks:
    - name: update apt cache
      apt:
        update_cache: yes

    - name: install nginx
      apt:
        name: nginx
        state: present

    - name: start nginx service
      service:
        name: nginx
        state: started
```
---
5. **Tasks section with variable section**
```yml
---
- name: Tasks section with variable section
  hosts: dev
  user: ansible
  become: yes
  connection: ssh
  gather_facts: no
  vars:
    web_package: nginx
    web_service: nginx
  tasks:
    - name: update apt cache
      apt:
        update_cache: yes
    - name: install web server
      apt:
        name: "{{ web_package }}"
        state: present
    - name: start web server service
      service:
        name: "{{ web_service }}"
        state: started
```
---
6. **task section with action module**
```yml
---
- name: task section with action module
  hosts: dev
  user: ansible
  become: yes
  connection: ssh
  gather_facts: no
  tasks:
    - name: update apt cache
      action: apt update_cache=yes
    - name: install nginx
      action: apt name=nginx state=present
    - name: start nginx service
      action: service name=nginx state=started
```
---

7. **variable section with action module**
```yml
---
- name: variable section with action module
  hosts: dev
  user: ansible
  become: yes
  connection: ssh
  gather_facts: no
  vars:
    web_package: nginx
    web_service: nginx
  tasks:
    - name: update apt cache
      action: apt update_cache=yes
    - name: install web server
      action: apt name={{ web_package }} state=present
    - name: start web server service
      action: service name={{ web_service }} state=started
```
---
8. **notify and handlers sections**
```yml
---
- name: notify and handlers sections
  hosts: dev
  user: ansible
  become: yes
  connection: ssh
  gather_facts: no
  tasks:
    - name: update apt cache
      apt:
        update_cache: yes
    - name: install nginx
      apt:
        name: nginx
        state: present
      notify: start nginx
  handlers:
    - name: start nginx
      service:
        name: nginx
        state: started
```
---
9. **Install multiple packages using loop script**
```yml
---
- name: Install multiple packages
  hosts: dev
  user: ansible
  become: yes
  connection: ssh
  gather_facts: no
  tasks:
    - name: Update apt cache
      apt:
        update_cache: yes
    - name: Install required packages 
      apt:
        name: "{{ item }}"
        state: present
      loop:
        - openjdk-17-jdk
        - git
        - curl
        - unzip
```
---
10. **script with condition on os family**
```yml
---
- name: script with condition on os family
  hosts: dev
  user: ansible
  become: yes
  connection: ssh
  gather_facts: no
  tasks:
    - name: Install apache2 on Debian
      apt:
        name: apache2
        state: present
        update_cache: yes
      when: ansible_os_family == "Debian"
    - name: Install httpd on RedHat
      yum:
        name: httpd
        state: present
      when: ansible_os_family == "RedHat"
```
---
11. **Ignore the error in tasks**
```yml
---
- name: Ignore the error in tasks
  hosts: dev
  user: ansible
  become: yes
  connection: ssh
  gather_facts: no
  tasks:
    - name: check for errors in task
      command: /bin/false
      ignore_errors: yes
```
---
12. **Copy the file to worker nodes**
```yml
---
- name: Copy script to worker nodes
  hosts: dev
  user: ansible
  become: yes
  connection: ssh
  gather_facts: no
  tasks:
    - name: Copy jen.sh to worker nodes
      copy:
        src: ./jen.sh
        dest: /home/ansible/jen.sh
```
---
13. **copy file and execute in the bash shell**
```yml
---
- name: Copy and execute script on worker nodes
  hosts: dev
  user: ansible
  become: yes
  connection: ssh
  gather_facts: no
  tasks:
    - name: Copy jen.sh to worker nodes
      copy:
        src: ./jen.sh
        dest: /home/ansible/jen.sh
        mode: '0755'   
    - name: Execute jen.sh script
      command: /home/ansible/jen.sh
```
---
14. **Docker image Pull and Run**
```yml
---
- name: Docker image Pull and Run
  hosts: dev
  user: ansible
  become: yes
  connection: ssh
  gather_facts: no
  tasks:
    - name: Pull nginx image
      docker_image:
        name: nginx
        source: pull
    - name: Run nginx container
      docker_container:
        name: nginx_web
        image: nginx
        state: started
        ports:
          - "80:80"
```
---
15. **Pull the src from the Git to given directory**
```yml
---
- name: Clone git repo to server
  hosts: dev
  user: ansible
  become: yes
  connection: ssh
  gather_facts: no
  tasks:
    - name: Ensure git is installed
      apt:
        name: git
        state: present
        update_cache: yes
    - name: Clone repository
      git:
        repo: 'https://github.com/sakit333/repo.git'
        dest: /opt/myrepo
        version: main
        update: yes
```
---
*Script Done by SAK*

