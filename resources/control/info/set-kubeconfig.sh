#!/bin/bash
#NOTE: source set-kubeconfig.sh
sudo cp /etc/kubernetes/admin.conf $HOME/
sudo chown $(id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf
#awk 'NR==1{print} NR==2{print "export KUBECONFIG=$HOME/admin.conf"} NR>1' $HOME/resources/control/running-job/view-job.sh > file_temp && mv file_temp $HOME/resources/control/running-job/view-job.sh

#awk 'NR==1{print} NR==2{print "export KUBECONFIG=$HOME/admin.conf"} NR>1' $HOME/resources/control/running-job/run-job.sh > file_temp && mv file_temp $HOME/resources/control/running-job/run-job.sh


#chmod +x $HOME/resources/control/running-job/view-job.sh
#chmod +x $HOME/resources/control/running-job/run-job.sh
