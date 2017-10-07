#/bin/bash

#环境重启
# cd /home/LIVE/docker-compose
# docker-compose restart &
# cd /opt/script
#sleep 4
#printf "exec 'cd /home/LIVE/docker-compose && docker-compose ps'  to check env\n"

# 分支输入
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
docker exec -i my-web bash -c "cd /opt/jar/ && sh common.sh $branch_name" 
# 因为是common包，所以不会特意有Dockerfile文件，仅仅在docker容器内部安装
