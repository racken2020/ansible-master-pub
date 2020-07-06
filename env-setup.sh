#!/usr/bin/env bash

mkdir -p keys client-specific client-specific/group_vars
ln -s client-specific/group_vars group_vars
#git pull --recurse-submodules
#git submodule update --recursive --remote
cp hosts.sample client-specific/hosts
