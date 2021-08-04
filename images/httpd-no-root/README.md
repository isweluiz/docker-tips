## Running httpd no-root 

#### Build image 

```bash
[isweluiz@localhost httpd-no-root]$ ./build-apache.sh 
STEP 1: FROM ubi7/ubi:7.7
STEP 2: LABEL description="apache server"
--> Using cache 5e21ee47a9ba7103efd9d1ec044ff118be26e5ab573c8eaae3d53bb87e58209b
--> 5e21ee47a9b
STEP 3: ENV PORT=8181
--> Using cache c8770a1145ae5fa030b2ac7cef6405eb7f2d98c702305e26e3b3303a85674491
--> c8770a1145a
STEP 4: RUN yum install httpd -y      && sed -i "s/Listen 80/Listen ${PORT}/g" /etc/httpd/conf/httpd.conf     && useradd -u 5000 app     && chown -R app:app -R /var/www/html     && chown -R app:app /etc/httpd/     && chown -R app:app /run/httpd/     && chown -R app:app /var/log/httpd/  
--> Using cache 6bd15bae5aa3adaf402a8a9df0ea097b327927499138b9f7119be8170f128d64
--> 6bd15bae5aa
STEP 5: EXPOSE ${PORT}
--> Using cache ae9b2169bd16f66c35d1b8ab526197329c64cba0c1794de5ad0bc5deaa5d51c1
--> ae9b2169bd1
STEP 6: USER app  
--> Using cache 865226be044dcbcdc42aceca1c034f75f5698afa9815601ccdb66864c04b28b8
--> 865226be044
STEP 7: ENTRYPOINT ["httpd"]
--> Using cache 08847e59a501783ceacf566075e8c33fee80fa9c923b9399e6ac2d1c475c76e0
--> 08847e59a50
STEP 8: CMD ["-D","FOREGROUND"]
--> Using cache f6de0d977789675e20130c575430eb8c9c5b9792d1e99aeb4193e41138187d00
STEP 9: COMMIT httpd-no-root
--> f6de0d97778
f6de0d977789675e20130c575430eb8c9c5b9792d1e99aeb4193e41138187d00
```

### Start httpd-no-root 

```bash
[isweluiz@localhost httpd-no-root]$ ./start-apache.sh 
294ca3deb25ecf1b25a3ec3bb140a61b1caaff8e4e5bb00adc6da72ca664ec0e
```

### Check 

```bash
[isweluiz@localhost httpd-no-root]$ curl localhost:8083  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
...........
...........

[isweluiz@localhost httpd-no-root]$ podman ps
CONTAINER ID  IMAGE                    COMMAND        CREATED         STATUS             PORTS                   NAMES
dbcfd186839c  localhost/httpd-no-root  -D FOREGROUND  10 minutes ago  Up 10 minutes ago  0.0.0.0:8083->8181/tcp  httpd
```
