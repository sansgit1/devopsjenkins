FROM centos:latest
RUN yum update -y
RUN yum install httpd -y
copy ./index.html /var/www/html
ENTRYPOINT ["/usr/sbin/httpd","-D","FOREGROUND"]
