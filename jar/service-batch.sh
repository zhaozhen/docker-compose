#!/bin/bash
branch_name=$1

s_path="/opt/jar/source/maitao-cloud/service-batch"
# w_path="/opt/jar/release"

t_path="/opt/jar/release/service-batch-$branch_name"

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

echo "Start Update Service-batch Source...................[OK]"
mvn clean compile package
cp -f $s_path/target/service-batch-1.0.0.jar $t_path/service-batch-1.0.0.jar
cp -f $s_path/src/main/docker/Dockerfile $t_path/Dockerfile

echo "Deploy Service-batch.jar ....................[OK]"