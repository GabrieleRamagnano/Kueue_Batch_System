#!/bin/bash
kubectl delete pod --all --grace-period=0 --force --namespace team-c
kubectl delete pod --all --grace-period=0 --force --namespace team-g
