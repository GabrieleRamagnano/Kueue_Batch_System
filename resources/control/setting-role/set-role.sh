#!/bin/bash

#create directory
mkdir $HOME/resources/role/chiara-user
mkdir $HOME/resources/role/gustavo-user

#create private key
openssl genrsa -out $HOME/resources/role/chiara-user/chiara.key 2048
openssl genrsa -out $HOME/resources/role/chiara-user/gustavo.key 2048
openssl req -new -key $HOME/resources/role/chiara-user/chiara.key -out  \
        $HOME/resources/role/chiara-user/chiara.csr -subj "/CN=chiara"
openssl req -new -key $HOME/resources/role/chiara-user/gustavo.key -out  \
        $HOME/resources/role/gustavo-user/gustavo.csr -subj "/CN=gustavo"

#create certificate signing request
cp $HOME/resources/role/template/certificate-chiara.yaml \
   $HOME/resources/role/chiara-user/certificate-chiara.yaml
cp $HOME/resources/role/template/certificate-gustavo.yaml \
   $HOME/resources/role/gustavo-user/certificate-gustavo.yaml

export CSR_BASE64=$(cat $HOME/resources/role/chiara-user/chiara.csr | base64 | tr -d "\n" )
export CSR_BASE64=$(cat $HOME/resources/role/gustavo-user/gustavo.csr | base64 | tr -d "\n" )

#note: it's neccessary to be install yq tool
yq eval --inplace '.spec.request = strenv(CSR_BASE64)' \
   $HOME/resources/role/gustavo-user/certificate-gustavo.yaml

#view certificate.yaml
cat $HOME/resources/role/chiara-user/certificate-chiara.yaml
cat $HOME/resources/role/gustavo-user/certificate-gustavo.yaml

#create csr for users chiara and gustavo
kubectl apply -f /resources/role/chiara-user/certificate-chiara.yaml
kubectl apply -f /resources/role/gustavo-user/certificate-gustavo.yaml
kubectl get csr

#approve csr
kubectl certificate approve chiara
kubectl certificate approve gustavo

#view csr
kubectl get csr/chiara -o yaml
kubectl get csr/gustavo -o yaml

#export the issued certificate from the CertificateSigningRequest
kubectl get csr chiara -o jsonpath='{.status.certificate}'| base64 -d > \
        $HOME/resources/role/chiara-user/chiara.crt
kubectl get csr gustavo -o jsonpath='{.status.certificate}'| base64 -d > \
        $HOME/resources/role/gustavo-user/gustavo.crt

#create rolebinding for chiara and gustavo
cp $HOME/resources/role/template/team-c-kueue-job-editor-role.yaml \
   $HOME/resources/role/chiara-user/team-c-kueue-job-editor-role.yaml
cp $HOME/resources/role/template/team-g-kueue-job-editor-role.yaml \
   $HOME/resources/role/gustavo-user/team-g-kueue-job-editor-role.yaml
kubectl apply -f /resources/role/template/team-c-kueue-job-editor-role.yaml
kubectl apply -f /resources/role/template/team-g-kueue-job-editor-role.yaml

#create kubeconfig for users chiara and gustavo
cp $HOME/resources/role/template/kubeconfig.yaml \
   $HOME/resources/role/chiara-user/kubeconfig.yaml
cp $HOME/resources/role/template/kubeconfig.yaml \
   $HOME/resources/role/gustavo-user/kubeconfig.yaml

#setting .key and .crt for chiara in kubeconfig's file
kubectl config set-credentials chiara \
        --client-key=$HOME/resources/role/chiara-user/chiara.key \
        --client-certificate=$HOME/resources/role/chiara-user/chiara.crt \
        --embed-certs=true --kubeconfig \
  $HOME/resources/role/chiara-user/kubeconfig.yaml

#setting .key and .crt for gustavo in kubeconfig's file
kubectl config set-credentials gustavo \
        --client-key=$HOME/resources/role/gustavo-user/gustavo.key \
        --client-certificate=$HOME/resources/role/gustavo-user/gustavi.crt \
        --embed-certs=true --kubeconfig \
  $HOME/resources/role/gustavo-user/kubeconfig.yaml

#set context for chiara and gustavo
kubectl config set-context chiara --cluster=mycluster --user=chiara --kubeconfig \
        $HOME/resources/role/chiara-user/kubeconfig.yaml
kubectl config set-context gustavo --cluster=mycluster --user=gustavo --kubeconfig \
        $HOME/resources/role/gustavo-user/kubeconfig.yaml

#I choose one of these context to verify code works correctly
kubectl config use-context chiara \
        --kubeconfig $HOME/resources/role/chiara-user/kubeconfig.yaml
#kubectl config use-context gustavo \
#       --kubeconfig $HOME/resources/role/gustavo-user/kubeconfig.yaml


#delete dummy variable in template file
kubectl config delete-context kube-admin-mycluster \
        --kubeconfig $HOME/resources/role/chiara-user/kubeconfig.yaml
kubectl config delete-context kube-admin-mycluster \
        --kubeconfig $HOME/resources/role/gustavo-user/kubeconfig.yaml
kubectl config delete-user kube-admin-mycluster \
        --kubeconfig $HOME/resources/role/chiara-user/kubeconfig.yaml
kubectl config delete-user kube-admin-mycluster \
        --kubeconfig $HOME/resources/role/gustavo-user/kubeconfig.yaml

#view final kubeconfig file
cat $HOME/resources/role/chiara-user/kubeconfig.yaml                                                   
cat $HOME/resources/role/gustavo-user/kubeconfig.yaml