#!/bin/bash

#delete directory
rm -r $HOME/resources/role/chira-user
rm -r $HOME/resources/role/gustavo-user

#delete csr
kubectl delete csr --all

#delete rolebinding
kubectl delete rolebinding --all -n team-c
kubectl delete rolebinding --all -n team-g
