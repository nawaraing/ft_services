FROM	alpine:3.12

RUN		apk update && apk add nginx && apk add wget ; \
		apk add lighttpd php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom ; \
		apk add php7 php7-fpm php7-opcache ; \
		apk add php7-gd php7-mysqli php7-zlib php7-curl ; \
		apk add php-json ; \
		apk add php7-session ; \
		apk add --no-cache openrc openssl openssh

RUN		wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz ; \
		tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz ; \
		rm phpMyAdmin-5.0.2-all-languages.tar.gz ; \
		mv phpMyAdmin-5.0.2-all-languages var/www/phpmyadmin

RUN		mkdir -p var/run/nginx

COPY	nginx.conf /etc/nginx/nginx.conf

COPY	config.inc.php /var/www/phpmyadmin/config.inc.php

COPY	start.sh .

RUN		chmod +x start.sh

EXPOSE	5000

CMD		["sh", "./start.sh" ]
