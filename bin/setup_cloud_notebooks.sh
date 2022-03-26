#!/bin/bash -xe

# -e tells it to exit if one of the scripts returns an err code

sudo apt-get update
sudo apt-get install emacs
sudo apt-get install less
sudo apt-get install tree

# Install ip command so I can figure out my ip address
sudo apt-get install iproute2

# Install ping command
sudo apt-get install iputils-ping

sudo apt-get install openssh-server

