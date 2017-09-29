function_release_spring()
{

  printf "Starting Compile Package Jar Registry...\n"
  sh /opt/jar/registry.sh

  printf "Releaseing Registry  Ports 9999...\n"

  sleep 8
  kill $(ps aux|grep java|grep registry-1.0.0.jar |awk '{print $2;}')


  nohup  java -jar -Xms160m -Xmx320m -XX:MaxMetaspaceSize=300m -XX:CompressedClassSpaceSize=80m -Xss256k -Xmn80m -XX:InitialCodeCacheSize=40m -XX:ReservedCodeCacheSize=80m -XX:MaxDirectMemorySize=160m /opt/jar/release/registry-1.0.0.jar  > /opt/logs/registry.log &

  printf "\n\n tail -f /opt/logs/registry.log \n"

}

function_log_spring()
{

  tail -f /opt/logs/registry.log 
}

function_stop_spring(){
    kill $(ps aux|grep java|grep registry-1.0.0.jar |awk '{print $2;}')
}
if [ "$1" = "release" ]; then
  function_release_spring
elif [ "$1" = "log" ]; then
  function_log_spring
elif [ "$1" = "log" ]; then
  function_stop_spring
else
  printf "Usage: sh /opt/scripts/registry.sh {release|log|stop}\n"
fi