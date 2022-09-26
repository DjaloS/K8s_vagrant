#!/bin/bash

helm install
echo "Install Helm"
sleep 2
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
sleep 5

sleep 5
chmod 700 get_helm.sh
PATH=/sbin:/bin:/usr/sbin:/usr/bin?:/usr/local/bin
./get_helm.sh
sleep 5

echo "Install Stack Prometheus-Grafana"
création du namespace monitoring
kubectl create ns monitoring 

sleep 5
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

sleep 10
helm install my-kube-prometheus-stack prometheus-community/kube-prometheus-stack --version 40.0.0 -n monitoring
sleep 2
