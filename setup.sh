#!/bin/bash
export MINIKUBE_HOME=/Users/junkang/goinfre

echo -e -n "\033[1;37mminikube deleting...\033[0m"
minikube delete > /dev/null;
echo -e "\033[32m Done!\033[0m"


echo -e -n "\033[1;37mminikube starting...\033[0m"
if		minikube start --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-35000 > /dev/null; then
	echo -e "\033[32m Done!\033[0m"
else
	echo -e "\033[31mFail!\033[0m"
	exit 1
fi

echo -e -n "\033[1;37mEval...\033[0m"
eval $(minikube docker-env) > /dev/null
echo -e "\033[32m Done!\033[0m"

echo -e -n "\033[1;37mBuild Pods and Services...\033[0m"
if		docker build -t nginx-img ./srcs/nginx/ \
	&& docker build -t mysql-img ./srcs/mysql/ \
	&& docker build -t phpmyadmin-img ./srcs/phpmyadmin/ \
	&& docker build -t wordpress-img ./srcs/wordpress/ \
	&& docker build -t influxdb-img ./srcs/influxdb/ \
	&& docker build -t telegraf-img ./srcs/telegraf/ \
	&& docker build -t grafana-img ./srcs/grafana/ \
	&& docker build -t ftps-img ./srcs/ftps/ > /dev/null; then
	echo -e "\033[32m Done!\033[0m"
else
	echo -e "\033[31mFail!\033[0m"
	exit 1
fi

echo -e -n "\033[1;37mApply Metallb...\033[0m"
if		kubectl get configmap kube-proxy -n kube-system -o yaml | \
		sed -e "s/strictARP: false/strictARP: true/" | \
		kubectl apply -f - -n kube-system > /dev/null \
	&& kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml > /dev/null \
	&& kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml > /dev/null \
	&& MINIKUBE_IP=$(minikube ip) > /dev/null \
	&& kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" > /dev/null \
	&& kubectl get all -n metallb-system > /dev/null \
	&& kubectl apply -f ./srcs/metallb/metallb.yaml > /dev/null; then
	echo -e "\033[32m Done!\033[0m"
else
	echo -e "\033[31mFail!\033[0m"
	exit 1
fi
	# sed "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/metallb/metallb_config.yaml > ./srcs/metallb/metallb.yaml

echo -e -n "\033[1;37mApply Pods and Services...\033[0m"
if		kubectl apply -f srcs/ftps/accounts.yaml > /dev/null \
	&& kubectl apply -f srcs/nginx/nginx.yaml > /dev/null \
	&& kubectl apply -f srcs/mysql/mysql.yaml > /dev/null \
	&& kubectl apply -f srcs/phpmyadmin/phpmyadmin.yaml > /dev/null \
	&& kubectl apply -f srcs/wordpress/wordpress.yaml > /dev/null \
	&& kubectl apply -f srcs/influxdb/influxdb.yaml > /dev/null \
	&& kubectl apply -f srcs/telegraf/telegraf.yaml > /dev/null \
	&& kubectl apply -f srcs/grafana/grafana.yaml > /dev/null \
	&& kubectl apply -f srcs/ftps/ftps.yaml > /dev/null; then # user password
	echo -e "\033[32m Done!\033[0m"
else
	echo -e "\033[31mFail!\033[0m"
	exit 1
fi

echo -e "\033[1;34mMinikube IP: $MINIKUBE_IP\033[0m"
minikube dashboard