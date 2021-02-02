FROM	alpine:3.12

# RUN		apk update
# RUN		apk add nginx
# RUN		apk add openrc
# RUN		apk add openssl
# RUN		apk add openssh
RUN		apk update && apk add nginx ; \
		apk add --no-cache openrc openssl openssh

RUN		mkdir -p var/run/nginx

COPY	index.html /www/
COPY	nginx.conf /etc/nginx/nginx.conf

RUN		openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/example.key -out /etc/nginx/example.crt -subj "/C=KR/ST=IDE/L=Seoul/O=42/OU=42/CN=osef.com" 
# RUN		openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj '/C=KR/ST=Seoul/L=Seoul/O=42Seoul/CN=localhost' -keyout /etc/nginx/nginx-selfsigned.key -out /etc/nginx/nginx-selfsigned.crt
RUN		chmod 600 /etc/nginx/example.crt /etc/nginx/example.key

RUN		apk add --no-cache openssh \
		&& sed 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' -i /etc/ssh/sshd_config \
		&& echo 'root:0000' | chpasswd \
		&& ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa \
		&& ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa \
		&& echo "Port 30022" >> /etc/ssh/sshd_config \
		&& mkdir -p /var/run/sshd

EXPOSE	80 443 30022

CMD		nginx -g "daemon off;"
