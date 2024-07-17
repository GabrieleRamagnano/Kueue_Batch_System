#!/bin/bash

#delete cluster-queue for team-c 
kubectl delete clusterqueue team-c-cq

#delete cluster-queue for team-g
kubectl delete clusterqueue team-g-cq

#delete WorkloadPriorityClass
kubectl delete workloadpriorityclass higher-priority
kubectl delete workloadpriorityclass lower-priority

#delete local-queue for team-c and team-g
kubectl delete localqueue lq-team-c -n team-c
kubectl delete localqueue lq-team-g -n team-g

#delete flavors
kubectl delete resourceflavor default-flavor

#delete namespace
kubectl delete ns team-c
kubectl delete ns team-g
