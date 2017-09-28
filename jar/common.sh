#!/bin/bash
branch_name=develop
echo ""
echo "     不需要输入 ticket，直接输入分支编号，develop分支请直接回车"
echo ""
read -p "Please enter a branch name, NOT Input is develop branch for default: ticket-" branchName
if  [ ! -n "$branchName" ] ;then
  echo "Use develop branch!"
else
  echo "Use $branchName branch!"
  branch_name=ticket-$branchName
fi

s_path="/opt/jar/source/maitao-cloud/common"
w_path="/opt/jar/release"

cd $s_path

git checkout $branch_name
git fetch origin
git reset --hard origin/$branch_name

echo "Start Update  Source...................[OK]"
#mvn clean compile package
mvn clean compile jar:jar
mvn install 
#cp -f $s_path/target/common-1.0.0.jar $w_path/common-1.0.0.jar
echo "Deploy Common.jar ....................[OK]"