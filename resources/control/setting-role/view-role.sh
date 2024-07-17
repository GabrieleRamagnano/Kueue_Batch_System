#!/bin/bash

#List of Certificate Signing Request
echo "-->list of csr"
kubectl get csr

#Retrieve the certificate form the CSR
echo "-->chiara-csr"
kubectl get csr/chiara -o yaml
echo "-->gustavo-csr"
kubectl get csr/gustavo -o yaml

#RoleBinding team-c and team-g
echo "-->rolebinding"
kubectl get rolebinding -n team-c
kubectl get rolebinding -n team-g

#kubeconfig
echo "--> kubeconfig file"
export KUBECONFIG=$HOME/resources/role/chiara-user/kubeconfig.yaml
#export KUBECONFIG=$HOME/resources/role/gustavo-user/kubeconfig.yaml
kubectl config view

#test
echo "--> TEST <--"
kubectl get job -n team-c
kubectl get job -n team-g




