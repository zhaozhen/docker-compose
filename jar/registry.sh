#!/bin/bash
# branch_name=develop
# echo ""
# echo "     不需要输入 ticket，直接输入分支编号，develop分支请直接回车"
# echo ""
# read -p "Please enter a branch name, NOT Input is develop branch for default: ticket-" branchName
# if  [ ! -n "$branchName" ] ;then
#   echo "Use develop branch!"
# else
#   echo "Use $branchName branch!"
#   branch_name=ticket-$branchName
# fi

branch_name=$1

s_path="/opt/jar/source/maitao-cloud/registry"
# w_path="/opt/jar/release"

t_path="/opt/jar/release/registry-$branch_name"

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

echo "Start Update Registry Source...................[OK]"
mvn clean compile package
cp -f $s_path/target/registry-1.0.0.jar $t_path/registry-1.0.0.jar
cp -f $s_path/src/main/docker/Dockerfile $t_path/Dockerfile

echo "Deploy registry.jar ....................[OK]"