echo -e -n "\033[1;37mminikube deleting...\033[0m"
minikube delete > /dev/null;
echo -e "\033[32m Done!\033[0m"

echo -e -n "\033[1;37mminikube starting...\033[0m"
if		minikube start --vm-driver=virtualbox; then
	echo -e "\033[32m Done!\033[0m"
else
	echo -e "\033[31mFail!\033[0m"
	exit 1
fi

kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system

echo -e -n "\033[1;37mEval...\033[0m"
eval $(minikube docker-env) > /dev/null
echo -e "\033[32m Done!\033[0m"

echo -e -n "\033[1;37mMetallb applying...\033[0m"
if	#kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl apply -f - -n kube-system && \
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml > /dev/null && \
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml > /dev/null && \
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" > /dev/null && \
	kubectl get all -n metallb-system && \
	kubectl apply -f srcs/metallb/metallb.yaml > /dev/null && \
	kubectl get svc; then
	echo -e "\033[32m Done!\033[0m"
else
	echo -e "\033[31mFail!\033[0m"
	exit 1
fi

IP="$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)"
echo -e "\033[1;34mCluster IP: $IP\033[0m"

echo -e -n "\033[1;37mBuild Pods and Services...\033[0m"
if	docker build -t nginx srcs/nginx; then
	# docker build -t mysql srcs/mysql && \
	# docker build -t phpmyadmin srcs/phpmyadmin && \
	# docker build -t grafana srcs/grafana && \
	# docker build -t telegraf srcs/telegraf && \
	# docker build -t influxdb srcs/influxdb && \
	# docker build -t wordpress srcs/wordpress; then
	echo -e "\033[32m Done!\033[0m"
else
	echo -e "\033[31mFail!\033[0m"
	exit 1
fi

echo -e -n "\033[1;37mApply Pods and Services...\033[0m"
if	kubectl apply -f srcs/nginx/nginx.yaml; then
	# kubectl apply -f srcs/mysql/mysql.yaml > /dev/null && \
	# kubectl apply -f srcs/phpmyadmin/phpmyadmin.yaml > /dev/null && \
	# kubectl apply -f srcs/grafana/grafana.yaml > /dev/null && \
	# kubectl apply -f srcs/telegraf/telegraf.yaml > /dev/null && \
	# kubectl apply -f srcs/influxdb/influxdb.yaml > /dev/null && \
	# kubectl apply -f srcs/wordpress/wordpress.yaml > /dev/null; then
	echo -e "\033[32m Done!\033[0m"
else
	echo -e "\033[31mFail!\033[0m"
	exit 1
fi

minikube dashboard> /dev/null
echo -e -n "\033[1;37mOpen dashboard\033[0m"