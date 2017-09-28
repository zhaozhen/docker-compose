function_release_spring()
{

  printf "Starting Compile Package WAR Registry...\n"
  sh /opt/jar/config.sh

  printf "Releaseing Registry  Ports 9999...\n"

  sleep 8
  kill $(ps aux|grep java|grep config-1.0.0.jar |awk '{print $2;}')


  nohup  java -jar -Xms160m -Xmx320m -XX:MaxMetaspaceSize=300m -XX:CompressedClassSpaceSize=80m -Xss256k -Xmn80m -XX:InitialCodeCacheSize=40m -XX:ReservedCodeCacheSize=80m -XX:MaxDirectMemorySize=160m /opt/jar/release/config-1.0.0.jar  > /opt/logs/config/config.log &

  printf "\n\n tail -f /opt/logs/config/config.log \n"

}

function_log_spring()
{

  tail -f /opt/logs/config/config.log 
}

if [ "$1" = "release" ]; then
  function_release_spring
elif [ "$1" = "log" ]; then
  function_log_spring
else
  printf "Usage: sh /opt/scripts/config.sh {release|log}\n"
fi