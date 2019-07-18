#!/bin/bash

clear

# configure and start the ipfs daemon
ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080
ipfs init --profile server
ipfs daemon > /substraTEE/output/ipfs_daemon1.log &

# allow the node to get ready
sleep 3s

# copy from the local build
# FIXME: remove this step
cp -R worker_local/bin/bin ./bin
cd bin

# start the worker 1
# cd /substraTEE/substraTEE-worker-master/bin
./substratee_worker getsignkey 2>&1 | tee /substraTEE/output/worker1_getsignkey.log
./substratee_worker getpublickey 2>&1 | tee /substraTEE/output/worker1_getpublickey.log
./substratee_worker -p 9977 -w 9111 -r 8111 --ns 192.168.10.10 --ws 192.168.10.21 worker 2>&1 | tee /substraTEE/output/worker1.log

read -p "Press enter to continue"