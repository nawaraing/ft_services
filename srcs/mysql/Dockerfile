FROM	alpine:3.12

RUN		apk add mariadb mariadb-client;

RUN		mkdir /run/mysqld;

COPY	mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY	my.cnf /etc/my.cnf

COPY	init.sql .

COPY	./start.sh .

RUN		chmod 777 start.sh

ENTRYPOINT	["./start.sh"]
