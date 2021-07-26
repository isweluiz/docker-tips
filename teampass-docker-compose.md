## Manage your passwords with Tempass - Open Source tool

### About teampass

![TemPass](https://i.ibb.co/dDxXHvr/teampass-print1.png)

TeamPass is a Passwords Manager dedicated for managing passwords in a collaborative way by sharing them among team members.
Teampass offers a large set of features permitting to manage your passwords and related data in an organized way in respect
to the access rights defined for each users. Teampass is an Open-Source free to use product distributed in respect with OpenSource GNU GPL-3.0.

- [Tempass on GitHub](https://github.com/nilsteampassnet/TeamPass)
- [Tempass on DockerHub](https://hub.docker.com/r/teampass/teampass/)
### List of teampass features

Teampass is highly customizable to fit your specific needs and constraints.

[Click here to see all features](https://teampass.net/features.html)

### Requirements 

- [Install Docker Compose](https://docs.docker.com/compose/install/) 
- [Install Docker](https://docs.docker.com/engine/install/)
- [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Download Configure and Install Temapass 

1. Clone teampass repository`s from your machine: 
```bash
$ git clone https://github.com/nilsteampassnet/TeamPass
```

2. Acess TeamPass folder
```bash
$ cd Tempass
$ mkdir volumes/teampass 
$ cp -Rp * ./volumes/teampass 
$ chmod 0777 ./volumes/tempass
```

3. Configure your docker-compose 
```bash
## Enable docker on machine`s start 
$ systemctl enable docker 
$ systemctl start docker 
$ vim docker-compose.yml 
```

```yml
version: "3"
services:

  nginx:
    privileged: true
    image: jwilder/nginx-proxy:alpine
    restart: always
    networks:
      - frontend
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./volumes/ssl:/etc/nginx/certs
      - /var/run/docker.sock:/tmp/docker.sock:ro

  teampass:
    privileged: true
    image: teampass/teampass
    restart: always
    environment:
      VIRTUAL_HOST: tempass.isweluiz.com.br
    networks:
      - frontend
      - backend
    volumes:
       - ./volumes/teampass:/var/www/html/

  db:
    privileged: true
    restart: always
    image: mysql/mysql-server:5.7
    environment:
      MYSQL_ROOT_PASSWORD: YYy5566teamredhat44
      MYSQL_DATABASE: teampass
      MYSQL_PASSWORD: YtrsPassOO99
      MYSQL_USER: teampass
    volumes:
      - ./volumes/db:/var/lib/mysql/
    networks:
      - backend

networks:
  frontend:
  backend:
```
Save and exit of the file. 

4. Run docker-compose 
```bash
$ docker-compose up -d 

$ docker ps 
CONTAINER ID        IMAGE                        COMMAND                  CREATED             STATUS                    PORTS                                      NAMES
97c2a182afd4        teampass/teampass            "/bin/sh /teampass..."   5 days ago          Up 47 minutes             80/tcp, 443/tcp, 9000/tcp                  teampass_teampass_1
5f38f6a628c9        jwilder/nginx-proxy:alpine   "/app/docker-entry..."   5 days ago          Up 47 minutes             0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp   teampass_nginx_1
91cc89e0f3e3        mysql/mysql-server:5.7       "/entrypoint.sh my..."   5 days ago          Up 47 minutes (healthy)   3306/tcp, 33060/tcp                        teampass_db_1
```
 
If some of theses containers dont starting up you can see the logs with `$ docker logs -f <container-id>`. 

5. Complete the installation 

Connect to your ip host http:// or https:// and finish the steps for finish the installation. On the database connect you will put 

Host: teampass_db_1 

Port: 33006 

User and password that you did put in docker-compose.yml. 


## LDAP configuration

Users authentication can be done through LDAP.

Teampass proposes the next setups:

- Windows / Active Directory
- Posix / OpenLDAP (RFC2307)
- Posix / OpenLDAP (RFC2307) Search Based

This page describes the setup using Posix / OpenLDAP (RFC2307) Search Based.

### Starting LDAP configuration

![LDAP-teampass](https://teampass.readthedocs.io/en/latest/img/ins-ldap-2.png)

The next settings form is given as an example

![Tempass-2](https://teampass.readthedocs.io/en/latest/img/ins-ldap-1.png)

This should be adapted to fit your LDAP server configuration. 

Case you have some questions about LDAP configuration, you can read the official documentation [here](https://teampass.readthedocs.io/en/latest/install/ldap/#ldap-configuration). 


# Some interesting features 

- [Automatic password change on remote server](https://teampass.readthedocs.io/en/latest/features/feat-remote/)
- [Import new items](https://teampass.readthedocs.io/en/latest/features/feat-impexp/)
- [Expiration ](https://teampass.readthedocs.io/en/latest/features/feat-expi/)
- [Manage the Folders](https://teampass.readthedocs.io/en/latest/manage/manage-folders/)
- [Manage the Groups](https://teampass.readthedocs.io/en/latest/manage/manage-groups/)



