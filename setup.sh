#!/bin/sh

echo -e -n "\033[1;37mStarting minikube...\033[0m"
minikube start --vm=true --vm-driver=docker --extra-config=apiserver.service-node-port-range=1-35000 > /dev/null
echo -e " \033[32mDone!\033[0m"
echo -e -n "\033[1;37mEnabling addons...\033[0m"
minikube addons enable metallb > /dev/null
minikube addons enable dashboard > /dev/null
minikube addons enable metrics-server > /dev/null
echo -e " \033[32mDone!\033[0m"
echo -e -n "\033[1;37mLaunching dashboard...\033[0m"
minikube dashboard & > /dev/null
echo -e " \033[32mDone!\033[0m"
echo -e "\033[1;37mEval...\033[0m"
eval $(minikube docker-env) > /dev/null
echo -e "\033[32mDone!\033[0m"

IP=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p) > /dev/null
echo -e "\033[1;34mMinikube IP: ${IP}\033[0m"

echo -e "\033[1;37mBuilding images...\033[0m"
docker build -t service_nginx ./imgs/nginx > /dev/null
echo -e "\033[32mNginx Done!\033[0m"

echo -e "\033[1;37mCreating pods and services...\033[0m"
kubectl create -f ./imgs/
echo -e "\033[32mDone!\033[0m"

echo -e  "\033[1;37mOpening the network in your browser\033[0m"
open http://$IP
