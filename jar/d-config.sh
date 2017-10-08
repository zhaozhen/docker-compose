#!/bin/bash

branch_name=$1

s_path="/opt/jar/source/maitao-cloud/config"

cd $s_path

git checkout $branch_name
git fetch origin
git reset --hard origin/$branch_name

echo "Start Update Config Source...................[OK]"
mvn clean package docker:build