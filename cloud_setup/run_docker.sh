#!/bin/bash

#usage: bash run_docker.sh /dev/sda4 /kdb my_docker djperrone/marmma_kraken

server_dev=$1
server_dir=$2
docker_name=$3
docker_repo=$4

sudo docker container run -it --name $docker_name -v $server_dir:$server_dev $docker_repo
