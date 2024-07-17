#!/bin/bash
export KUBECONFIG=$HOME/resources/role/chiara-user/kubeconfig.yaml
#export KUBECONFIG=$HOME/resources/role/gustavo-user/kubeconfig.yaml
kubectl config view
