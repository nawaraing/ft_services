FROM	alpine:latest

RUN		apk update && apk add nginx ; \
		apk add --no-cache openrc openssl openssh

RUN		mkdir -p var/run/nginx

COPY	index.html /www/

COPY	nginx.conf /etc/nginx/nginx.conf
COPY	build.sh ./
COPY	supervisord.conf /etc/supervisord.conf

RUN		openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/example.key -out /etc/nginx/example.crt -subj "/C=KR/ST=IDE/L=Seoul/O=42/OU=42/CN=osef.com" 

EXPOSE	80 22 443

CMD	nginx -g "daemon off;"
