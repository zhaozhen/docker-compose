#/bin/bash

#输入分支
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

#打包该分支，如果没有改分支则使用develop进行打包
docker exec -i my-build bash -c "cd /opt/jar/ && sh service-log.sh $branch_name" 

##编译docker容器，并运行
### 停止容器
docker stop service-log-$branch_name
### 删除容器
docker rm service-log-$branch_name
### 删除镜像
docker rmi service-log:$branch_name
### 重新编译镜像
cd /opt/release/service-log-$branch_name && docker build -t  service-log:$branch_name . 
### 运行镜像
docker run -itd  --name service-log-$branch_name  -p 8096:8096 service-log:$branch_name
