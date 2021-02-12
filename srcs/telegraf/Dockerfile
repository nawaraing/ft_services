FROM alpine:3.12

RUN apk update && apk upgrade
RUN apk add wget

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.14.0-static_linux_amd64.tar.gz
RUN tar -xzf telegraf-1.14.0-static_linux_amd64.tar.gz
RUN mv /telegraf /etc/
RUN rm -rf telegraf-1.14.0-static_linux_amd64.tar.gz

COPY ./telegraf.conf /etc/telegraf

WORKDIR /etc/telegraf
CMD ["./telegraf"]
#FROM alpine:latest

#RUN apk update \
#		&& apk upgrade \
#		&& apk add wget \
#		&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.13.3_linux_amd64.tar.gz \
#		&& tar -xzf telegraf-1.13.3_linux_amd64.tar.gz \
#		&& rm -rf telegraf-1.13.3_linux_amd64.tar.gz \
#		&& mv /telegraf/ /etc/ \
#		&& rm -rf /var/cache/apk/*
#COPY	telegraf.conf /etc/telegraf
#COPY	setup.sh ./
#RUN		chmod 755 setup.sh
#ENTRYPOINT ./setup.sh
