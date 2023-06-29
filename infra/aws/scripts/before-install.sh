#!/bin/bash
set -xe

# Delete the old  directory as needed.
if [ -d /home/ec2-user/app ]; then
    rm -rf /home/ec2-user/app/
fi

mkdir -vp /home/ec2-user/app/