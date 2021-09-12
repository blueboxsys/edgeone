#!/bin/bash

set -x

# wget http://download.redis.io/redis-stable.tar.gz
# tar xvzf 
# cd redis-stable

amazon-linux-extras install epel -y
yum install gcc jemalloc-devel openssl-devel tcl tcl-devel -y

cd /tmp/src && tar -xvzf /tmp/src/redis-stable.tar.gz

cd /tmp/src/redis-stable

#make BUILD_TLS=yes

gmake && gmake install

