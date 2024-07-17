#!/bin/bash

#create flavors
kubectl apply -f /resources/kueue/flavors/flavors.yaml

#create cluster-queue for team-c
kubectl apply -f /resources/kueue/cluster-queue/cluster-queue-c.yaml

#create cluster-queue for team-g
kubectl apply -f /resources/kueue/cluster-queue/cluster-queue-g.yaml

#create namespace
kubectl create ns team-c
kubectl create ns team-g

#create local-queue for team-c and team-g
kubectl apply -f /resources/kueue/local-queue/local-queue.yaml

#create WorkloadPriorityClass
kubectl create -f /resources/priority/higher-priority.yaml
kubectl create -f /resources/priority/lower-priority.yaml
