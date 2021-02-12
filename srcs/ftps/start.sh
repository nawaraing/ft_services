#!/bin/sh

adduser -D -h /ftp/user -s /bin/sh user
echo "user:password" | /usr/sbin/chpasswd
chown -R user:user /ftp/user

# Point to the internal API server hostname
APISERVER=https://kubernetes.default.svc

# Path to ServiceAccount token
SERVICEACCOUNT=/var/run/secrets/kubernetes.io/serviceaccount

# Read this Pod's namespace
NAMESPACE=$(cat ${SERVICEACCOUNT}/namespace)

# Read the ServiceAccount bearer token
TOKEN=$(cat ${SERVICEACCOUNT}/token)

# Reference the internal certificate authority (CA)
CACERT=${SERVICEACCOUNT}/ca.crt

SERVICE=$(echo $HOSTNAME | cut -d- -f1)
ADDR=""
until [ ! $ADDR == "" ]
do
	ADDR=$(curl --cacert ${CACERT} --header "Authorization: Bearer ${TOKEN}" -X GET ${APISERVER}/api/v1/namespaces/$NAMESPACE/services/$SERVICE/ 2>/dev/null| jq -r '.status | .loadBalancer | .ingress | .[] | .ip')
done
sed -i "s/pasv_address=ADDR/pasv_address=$ADDR/g" /etc/vsftpd/vsftpd.conf

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
