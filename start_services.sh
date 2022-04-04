#!/bin/sh

# Generate templates
make -f k8s-tpl.mak templates

# start services
make -f eks.mak start

# start previsions
make -f k8s.mak provision

# prevision context
kubectl config set-context --current --namespace=c756ns

# create and deploy metrics server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# deploy autoscaling for db service
kubectl create -f ./cluster/10-db-hpa.yaml

# deploy autoscaling for s1 service
kubectl create -f ./cluster/10-s1-hpa.yaml

# deploy autoscaling for s2 service
kubectl create -f ./cluster/10-s2-hpa.yaml

# print grafana url
make -f k8s.mak grafana-url

#print kiali url
make -f k8s.mak kiali-url

#print prometheus url
make -f k8s.mak prometheus-url
