#!/bin/bash

#usage: sudo bash create_filesystem.sh /dev/sda4 /kdb

server_dev=$1
server_dir=$2
docker_dev=$server_dev
#docker_repo=$4

sudo mkfs $server_dev
sudo mkdir $server_dir
sudo mount $server_dev $server_dir
sudo mount -v | grep $server_dir
sudo chmod 777 $server_dir
