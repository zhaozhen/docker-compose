#!/bin/bash

branch_name=$1

s_path="/opt/jar/source/maitao-cloud/turbine"
# w_path="/opt/jar/release"

t_path="/opt/jar/release/turbine-$branch_name"

if [  -d  $t_path ]; then
  rm -fr $t_path;
  mkdir -p $t_path
fi

if [ ! -d $t_path ]; then
  mkdir -p $t_path
fi

cd $s_path

git checkout $branch_name
git fetch origin
git reset --hard origin/$branch_name

echo "Start Update turbine Source...................[OK]"
mvn clean compile package
cp -f $s_path/target/turbine-1.0.0.jar $t_path/turbine-1.0.0.jar
cp -f $s_path/src/main/docker/Dockerfile $t_path/Dockerfile

echo "Deploy turbine.jar ....................[OK]"