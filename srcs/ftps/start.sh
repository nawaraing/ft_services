#!/bin/sh

adduser -D -h /var/ftp junkang
echo "junkang:password" | chpasswd

vsftpd /etc/vsftpd/vsftpd.conf
