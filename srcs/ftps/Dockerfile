FROM alpine:3.12

RUN apk update \
		&& apk upgrade \
		&& apk add vsftpd \
		&& apk add openrc \
		&& rc default \
		&& rc-service vsftpd restart \
		&& apk add openssl \
		&& apk add curl && apk add jq \
		&& rm -rf /var/cache/apk/* \
		&& apk add bash
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj       '/C=KR/ST=42/L=Seoul/O=42/CN=youlee' -keyout /etc/ssl/ftp-selfsigned.key -out /etc/ssl/ftp-selfsigned.crt
RUN mkdir -p ftp/user
COPY start.sh ./
RUN chmod 755 start.sh
COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
RUN chown -R root /etc/vsftpd/*
EXPOSE 20 21 10020 10021
ENTRYPOINT ./start.sh
