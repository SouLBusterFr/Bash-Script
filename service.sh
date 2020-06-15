#!/bin/bash

if [ "$#" = 0 ]
then
echo "Usage $0 sevice_name"
exit 1
fi

service=$1

exist=`ls /etc/init.d/ | grep -w $service | wc -l | awk '{print $1}'`
if [ $exist = "1" ]
then
is_running=`ps aux | grep -v grep| grep -v "$0" | grep $service| wc -l | awk '{print $1}'`
if [ $is_running != "0" ]
then
echo "le service est allumé, voulez vous l'arreter y/n ?"
read stop
if [ $stop = "y" ];
then
sudo /etc/init.d/$service stop
else
echo "le service est toujours allumé !"
exit 1
fi
elif [ $is_running = "0" ]
then
sudo /etc/init.d/$service start
echo "Service lancé !"
exit 1
fi
else
echo "le service n'existe pas veuillez réessayer"
fi
