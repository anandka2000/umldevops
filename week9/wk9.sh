#!/bin/bash -x

# Install minikube
# install kubectl

PVF=./jenkins-pvc.yaml
SERVF=./jenkins-full-deployment.yaml 
NS=devops2-tools
WHR_SECRET=whr-credentials

#minikube delete
#minikube start
kubectl delete namespace $NS

# Create namespace
kubectl create namespace $NS

# create secret for webhook pod
kubectl create secret generic $WHR_SECRET \
 --from-literal=key=8bd4fb50-7da4-4c02-9266-bbf7fc280cc0 \
 --from-literal=secret=1NdXupJO0bOc		\
 --namespace $NS

# create PV
kubectl apply -f $PVF -n $NS

# create Sevice/deployment
kubectl apply -f $SERVF -n $NS

# check pods
kubectl get pods -n $NS
# check service
kubectl get service -n $NS

#kubectl port-forward service/jenkins-service 8080:8080 -n $NS


#kubectl create clusterrolebinding permissive-binding --clusterrole=cluster-admin --user=admin --user=kubelet --group=system:serviceaccounts
