FROM	alpine:3.12

RUN		apk update \
		&& apk add nginx \
		&& apk add openssl \
		&& apk add jq \
		&& apk add curl

RUN		apk add --no-cache openssh
RUN		adduser -D -g 'www' www
RUN		echo 'www:0000'|chpasswd
RUN		ssh-keygen -f /etc/ssh/ssh_host_rsa_key -t rsa
RUN		chmod 600 /etc/ssh/ssh_host_rsa_key
RUN		chmod 600 /etc/ssh/ssh_host_rsa_key.pub
RUN		chown -R www:www /var/lib/nginx
RUN		mkdir /www
RUN		chown -R www:www /www

COPY	index.html /www/index.html
RUN		chmod 755 /www/*
RUN		mkdir -p etc/nginx/ssl
RUN		mkdir -p run/nginx
RUN		mkdir -p var/run/sshd
COPY	nginx.conf /etc/nginx/nginx.conf
COPY	sshd_config etc/ssh/sshd_config
COPY 	start.sh ./
RUN 	chmod 777 ./start.sh

RUN		openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=KR/ST=42/L=Seoul/O=42/CN=junkang' -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt

ENTRYPOINT ./start.sh
# CMD		nginx -g "daemon off;"

EXPOSE	80 443 30022