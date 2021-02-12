FROM	alpine:3.12

RUN		apk update && apk add nginx && apk add wget && apk add bash && apk add mysql-client; \
    	apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-curl php7-mbstring php7-json php7-session php7-zlib
    	# apk add php7-zlib php7-common ; \
		# apk add supervisor; \
		# apk add --update cache ; \
		# apk add php-bz2 ; \
		# apk add --no-cache openrc openssl openssh
RUN		rm -fr /var/cache/apk/*


RUN		wget http://wordpress.org/latest.tar.gz
RUN		tar -xzvf latest.tar.gz
RUN		rm latest.tar.gz
RUN		mv wordpress /var/www/
RUN		chmod 755 /var/www/wordpress

# RUN		apk add curl ; \
# 		apk add php-phar ; \
# 		apk add sudo ; \
# 		apk add php7-iconv ; \
# 		curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar ; \
# 		chmod +x wp-cli.phar ; \
# 		sudo mv wp-cli.phar /usr/local/bin/wp ; \
# 		apk add mysql-client

RUN		mkdir -p /run/nginx
RUN		mkdir -p /etc/wordpress

COPY	./wp-config.php var/www/wordpress/
COPY	nginx.conf /etc/nginx/nginx.conf
COPY	wordpress.sql .
COPY	start.sh .
COPY	create.sh .
RUN		chmod 755 start.sh
RUN		chmod 777 create.sh
RUN		chmod 777 wordpress.sql
CMD		./start.sh
# CMD		["sh", "./start.sh"]

EXPOSE	5050