FROM 	alpine:3.12

RUN  	    apk update
RUN 	    apk add nginx
RUN	    apk add openssl
RUN	    apk add openssh
RUN	    apk add openrc
RUN         apk add supervisor

RUN	mkdir	-p /run/nginx
RUN     apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache
RUN     mkdir -p /etc/telegraf

COPY    /srcs/build.sh      	./
COPY    /srcs/telegraf.conf 	/etc/telegraf/
COPY	/srcs/nginx.key		/etc/ssl/private/nginx.key
COPY    /srcs/nginx.crt		/etc/ssl/certs/nginx.crt
COPY 	/srcs/nginx.conf	/etc/nginx/nginx.conf
COPY    /srcs/supervisord.conf  /etc/supervisord.conf
COPY    /srcs/sshd_config   	/etc/ssh/sshd_config
COPY    /srcs/run.sh        	./

EXPOSE      80
EXPOSE	    22
EXPOSE      443

RUN         chmod +x build.sh

CMD         sh build.sh
