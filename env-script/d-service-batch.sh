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
docker exec -i my-build bash -c "cd /opt/jar/ && sh d-service-batch.sh $branch_name" 

##编译docker容器，并运行
### 停止容器
docker stop service-batch-$branch_name
### 删除容器
docker rm service-batch-$branch_name
### 运行镜像
docker run -itd  --name service-batch-$branch_name  -p 8090:8090 service-batch:1.0.0
