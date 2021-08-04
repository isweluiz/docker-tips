#!/bin/bash
podman run -dt --name httpd -p 8083:8181  httpd-no-root 
