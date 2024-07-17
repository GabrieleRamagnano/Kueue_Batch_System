#!/bin/bash

#check kueue system
echo "Flavors"
kubectl get flavors
echo "Namespaces"
kubectl get ns 
echo "Cluster-queue"
kubectl get clusterqueue
echo "Local-queue"
kubectl get localqueue -n team-c
kubectl get localqueue -n team-g
echo "Workload Priority Class"
kubectl get workloadpriorityclass
echo "Job"
kubectl get job -n team-c
kubectl get job -n team-g
