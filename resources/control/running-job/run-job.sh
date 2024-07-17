#!/bin/bash
counter=1
while [ $counter -le 5 ]
do
        kubectl create -f /resources/kueue/job/job-team-cpu.yaml
        kubectl create -f /resources/kueue/job/job-team-gpu.yaml
        counter=$((counter + 1))
done

echo "Cycle completed"
