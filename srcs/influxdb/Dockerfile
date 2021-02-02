FROM	alpine:3.12

RUN		apk update && apk add influxdb ; \
		apk add ca-certificates

EXPOSE	8086

CMD		influxd run -config /etc/influxdb.conf
