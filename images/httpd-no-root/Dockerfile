FROM ubi7/ubi:7.7
LABEL description="apache server"
ENV PORT=8181
RUN yum install httpd -y  \
    && sed -i "s/Listen 80/Listen ${PORT}/g" /etc/httpd/conf/httpd.conf \
    && useradd -u 5000 app \
    && chown -R app:app -R /var/www/html \
    && chown -R app:app /etc/httpd/ \
    && chown -R app:app /run/httpd/ \
    && chown -R app:app /var/log/httpd/  
EXPOSE ${PORT}
USER app  
ENTRYPOINT ["httpd"]
CMD ["-D","FOREGROUND"]
