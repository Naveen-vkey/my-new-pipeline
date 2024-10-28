#!/bin/sh

# jarfiles_path="/Users/navaneethakrishnan.m/Documents/TEST/docker-images"
vtrack_log4j_dir="$jarfiles_path/logs/vtrack"
prov_log4j_dir="$jarfiles_path/logs/prov"
vtap_log4j_dir="$jarfiles_path/logs/vtap"
asp_log4j_dir="$jarfiles_path/logs/asp"
smp_log4j_dir="$jarfiles_path/logs/smp"
varchive_log4j_dir="$jarfiles_path/logs/varchive"
tms_log4j_dir="$jarfiles_path/logs/tms"

display_help() {
    echo "Usage: $0 [command...]" >&2
    echo "List of commands:"
    echo "-h              Show help"
    echo "ls              Show list of services name"
    echo "start           Start service. eg: run.sh start [service-name]"
    echo "stop            Stop service. eg: run.sh stop [service-name]"
    echo "restart         Restart service. eg: run.sh restart [service-name]"
    echo
    exit 0
}

display_services() {
    echo "List of services:"
    echo "all                         -> All services"
    echo "vk-registry                 -> Registry service"
    echo "vk-config                   -> Config service"
    echo "vk-gateway                  -> Gateway service"
    echo "vk-audit                    -> Audit service"
    echo "vk-vos-dashboard            -> VOS Dashboard service"
    echo "vk-admin                    -> Admin service"
    echo "vk-ekyc-cust                -> EKYC customer setup"
    echo "vk-ekyc-regn                -> EKYC registration service"
    echo "vk-ekyc-scor                -> EKYC score matching service"
    echo "vk-ekyc-dash                -> EKYC dashboard service"
    echo "vk-ekyc-data                -> EKYC data collection service"
    echo "vk-ekyc-pass                -> EKYC passport service"
    echo "vk-cert-batch               -> EKYC certificate batch service"
    echo "vk-provision                -> Provisioning service"
    echo "vk-vtap                     -> VTAP service"
    echo "vk-vtrack                   -> V-Track service"
    echo "vk-asp                      -> ASP service"
    echo "vk-smp                      -> SMP service"
    echo "vk-tms                      -> TMS service"
    echo "vk-batchloader              -> Batchloader service"
    echo "vk-varchive                 -> V-Archive service"
    echo "vk-ekyc-pass                -> Epassport Validator service"
    echo "vk-cert-batch               -> Certification Batch Jobs service"
    echo "vk-config-dashboard         -> Config Dashboard service"
    echo "vk-fido2                    -> Fido2 service"
    echo "vk-csss-kms                 -> CSSS-KMS Service"
    echo "vk-threat-intel             -> Threat-intel service"
    echo "vk-auth-server              -> Auth-server service"
    echo "vk-troubleshooting-logs     -> TL service"
    echo
    exit 0
}

start_all() {
  mkdir -p logs  >/dev/null 2>&1
  echo "START all the services...."
  exec -a vk-registry java -Xms1024m -Dlogstash.host= -Dlogstash.port= -jar $jarfiles_path"registry.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-config java -Xms1024m -Dlogstash.host= -Dlogstash.port= -jar $jarfiles_path"config.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  sleep 200s;
  #exec -a vk-gateway java -Xms1024m -Dlogstash.host= -Dlogstash.port= -jar $jarfiles_path"gateway.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-config-dashboard java -Xms1024m -Dlogstash.host= -Dlogstash.port= -jar $jarfiles_path"config-dashboard.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-admin java -Xms1024m -Dlogstash.host= -Dlogstash.port= -jar $jarfiles_path"sboot-admin-ms.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-audit java -Xms1024m -Dlogstash.host= -Dlogstash.port= -jar $jarfiles_path"audit.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-ekyc-cust java -Xms1024m -Dlogstash.host= -Dlogstash.port= -jar $jarfiles_path"dbrdekycust.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-ekyc-regn java -Xms1024m -Dlogstash.host= -Dlogstash.port= -jar $jarfiles_path"fbs-regn.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-ekyc-scor java -Xms1024m -Dlogstash.host= -Dlogstash.port= -jar $jarfiles_path"fbs-scorecal.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-ekyc-dash java -Xms1024m -Dlogstash.host= -Dlogstash.port= -Dserver.ssl.key-store=/data2/httpd-config/httpd-config-from-poc/conf.d/certificate.p12 -Dserver.ssl.key-store-password=123456 -Dserver.ssl.keyStoreType=PKCS12 -Deureka.instance.nonSecurePortEnabled=false -Deureka.instance.securePortEnabled=true -jar $jarfiles_path"ekyc-dashboard.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-ekyc-data java -Xms1024m -Dlogstash.host= -Dlogstash.port= -jar $jarfiles_path"fbs-data.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-provision java -Xms1024m -Dlogstash.host= -Dlogstash.port= -Dprov.log4j.dir=$prov_log4j_dir -jar $jarfiles_path"provision.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-vtap java -Xms1024m -Dlogstash.host= -Dlogstash.port= -Dvtap.log4j.dir=$vtap_log4j_dir -jar $jarfiles_path"vtap.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-vtrack java -Xms1024m -Dlogstash.host= -Dlogstash.port= -Dvtrack.log4j.dir=$vtrack_log4j_dir -Dserver.ssl.key-store=/data2/httpd-config/httpd-config-from-poc/conf.d/certificate.p12 -Dserver.ssl.key-store-password=123456 -Dserver.ssl.keyStoreType=PKCS12 -jar $jarfiles_path"vtrack.war" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-asp java -Xms1024m -Dlogstash.host= -Dlogstash.port= -Dasp.log4j.dir=$asp_log4j_dir -jar $jarfiles_path"asp.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-smp java -Xms1024m -Dlogstash.host= -Dlogstash.port= -Dsmp.log4j.dir=$smp_log4j_dir -jar $jarfiles_path"smp.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-tms java -Xms1024m -Dlogstash.host= -Dlogstash.port= -Dtms.log4j.dir=$tms_log4j_dir -jar $jarfiles_path"tms.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-batchloader java -Xms1024m -Dlogstash.host= -Dlogstash.port= -jar $jarfiles_path"batchloader.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-varchive java -Xms1024m -Dlogstash.host= -Dlogstash.port= -Dvarchive.log4j.dir=$varchive_log4j_dir -jar $jarfiles_path"varchive.war" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-ekyc-pass java -Xms1024m -Dlogstash.host= -Dlogstash.port= -jar $jarfiles_path"epassport-validator.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-cert-batch java -Xms1024m -Dlogstash.host= -Dlogstash.port= -jar $jarfiles_path"certificate-batch.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-vos-dashboard java -Xms1024m -Dlogstash.host= -Dlogstash.port= -jar $jarfiles_path"vos-dashboard.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-csss-kms java -Xms1024m -Dlogstash.host= -Dlogstash.port= -jar $jarfiles_path"csss-kms.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-troubleshooting-logs java -Xms1024m -Dlogstash.host= -Dlogstash.port= -Dtms.log4j.dir=$tms_log4j_dir -jar $jarfiles_path"troubleshooting-logs.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
  exec -a vk-auth-server java -Xms1024m -Dlogstash.host= -Dlogstash.port= -Dtms.log4j.dir=$tms_log4j_dir -jar $jarfiles_path"auth-server.jar" --spring.config.additional-location=application.properties >/dev/null 2>&1 &
}

start_service() {
    mkdir -p logs  >/dev/null 2>&1
    serviceName=$1
    echo "Start Service" $serviceName
    case "$1" in
      vk-registry)
        jarName=registry.jar
        ;;
      vk-gateway)
        jarName=gateway.jar
        ;;
      vk-audit)
        jarName=audit.jar
        ;;
      vk-vos-dashboard)
        jarName=vos-dashboard.jar
        ;;
      vk-csss-kms)
        jarName=csss-kms.jar
        ;;
      vk-admin)
        jarName=admin.jar
        ;;
      vk-ekyc-cust)
        jarName=dbrdekycust.jar
        ;;
      vk-ekyc-regn)
        jarName=fbs-regn.jar
        ;;
      vk-ekyc-scor)
        jarName=fbs-scorecal.jar
        ;;
      vk-ekyc-dash)
        jarName=ekyc-dashboard.jar
        ;;
      vk-fbs-data)
        jarName=fbs-data.jar
        ;;
      vk-config)
        jarName=config.jar
        ;;
      vk-provision)
        jarName=provision.jar
        ;;
      vk-vtap)
        jarName=vtap.jar
        ;;
      vk-vtrack)
        jarName=vtrack.war
        ;;
      vk-vtrack-ti)
        jarName=vtrack-ti.war
        ;;
      vk-asp)
        jarName=asp.jar
        ;;
      vk-smp)
        jarName=smp.jar
        ;;
      vk-tms)
        jarName=tms.jar
        ;;
      vk-batchloader)
        jarName=batchloader.jar
        ;;
      vk-varchive)
        jarName=varchive.war
        ;;
      vk-ekyc-pass)
        jarName=epassport-validator.jar
        ;;
      vk-tms-otp)
        jarName=tms-otp.jar
        ;;
      vk-batchloader-otp)
        jarName=batchloader-otp.jar
        ;;
      vk-threat-intel)
        jarName=threat-intel.jar
        ;;
      vk-cert-batch)
        jarName=certificate-batch.jar
        ;;
      vk-fido2)
        jarName=fido2.jar
        ;;
      vk-config-dashboard)
        jarName=config-dashboard.jar
        ;;
      vk-auth-server)
        jarName=auth-server.jar
        ;; 
      vk-troubleshooting-logs)
        jarName=troubleshooting-logs.jar
        ;;
      *)
        display_help
        exit 1
        ;;
    esac

    deployed_jarfiles="$jarfiles_path$jarName"
    echo "Start service with memory: $JAVA_OPTS"
    echo $deployed_jarfiles
    case $serviceName in
      vk-registry)
         java -Ddd.agent.host=$DD_AGENT_HOST -Ddd.agent.port=8126 $JAVA_OPTS -Dlogstash.host= -Dlogstash.port= -Dlogstash.host= -Dlogstash.port= -jar $jarfiles_path"registry.jar" --spring.config.additional-location=application.properties
       ;;
      vk-config)
         java -Ddd.agent.host=$DD_AGENT_HOST -Ddd.agent.port=8126 $JAVA_OPTS -Dlogstash.host= -Dlogstash.port= -Dlogstash.host= -Dlogstash.port= -jar $jarfiles_path"config.jar" --spring.config.additional-location=application.properties
       ;;
      vk-vtap)
         java -Ddd.agent.host=$DD_AGENT_HOST -Ddd.agent.port=8126 $JAVA_OPTS -Dlogstash.host= -Dlogstash.port= -Dvtap.log4j.dir=$vtap_log4j_dir -jar $jarfiles_path"vtap.jar" --spring.config.additional-location=application.properties
       ;;
      vk-asp)
         java -Ddd.agent.host=$DD_AGENT_HOST -Ddd.agent.port=8126 $JAVA_OPTS -Dlogstash.host= -Dlogstash.port= -Dasp.log4j.dir=$asp_log4j_dir -jar $jarfiles_path"asp.jar" --spring.config.additional-location=application.properties
       ;;
      vk-smp)
         java -Ddd.agent.host=$DD_AGENT_HOST -Ddd.agent.port=8126 $JAVA_OPTS -Dlogstash.host= -Dlogstash.port= -Dsmp.log4j.dir=$smp_log4j_dir -jar $jarfiles_path"smp.jar" --spring.config.additional-location=application.properties
       ;;
      vk-batchloader)
         java -Ddd.agent.host=$DD_AGENT_HOST -Ddd.agent.port=8126 $JAVA_OPTS -Dlogstash.host= -Dlogstash.port= -jar $jarfiles_path"batchloader.jar" --spring.config.additional-location=application.properties
       ;;
      vk-vtrack)
         java -Ddd.agent.host=$DD_AGENT_HOST -Ddd.agent.port=8126 $JAVA_OPTS -Dlogstash.host= -Dlogstash.port= -Dvtrack.log4j.dir=$vtrack_log4j_dir -Dserver.ssl.key-store=/root/additional-files/vtrack/vtrack.p12 -Dserver.ssl.key-store-password=123456 -Dserver.ssl.keyStoreType=PKCS12 -jar $jarfiles_path"vtrack.war"  --spring.config.additional-location=application.properties #-Dserver.ssl.key-store=/root/additional-files/vtrack.p12 -Dserver.ssl.key-store-password=123456 -Dserver.ssl.keyStoreType=PKCS12
       ;;
      vk-vtrack-ti)
         java -Ddd.agent.host=$DD_AGENT_HOST -Ddd.agent.port=8126 $JAVA_OPTS -Dlogstash.host= -Dlogstash.port= -Dvtrack.log4j.dir=$vtrack_log4j_dir -Dserver.ssl.key-store=/root/additional-files/vtrack-ti/vtrack-ti.p12 -Dserver.ssl.key-store-password=123456 -Dserver.ssl.keyStoreType=PKCS12 -jar $jarfiles_path"vtrack-ti.war"  --spring.config.additional-location=application.properties --vtrack.legacy-screen=false
       ;;
      vk-provision)
         java -Ddd.agent.host=$DD_AGENT_HOST -Ddd.agent.port=8126 $JAVA_OPTS -Dlogstash.host= -Dlogstash.port= -Dprov.log4j.dir=$prov_log4j_dir -jar $jarfiles_path"provision.jar" --spring.config.additional-location=application.properties
       ;;
      vk-varchive)
         java -Ddd.agent.host=$DD_AGENT_HOST -Ddd.agent.port=8126 $JAVA_OPTS -Dlogstash.host= -Dlogstash.port= -Dvarchive.log4j.dir=$varchive_log4j_dir -jar $jarfiles_path"varchive.war" --spring.config.additional-location=application.properties
       ;;
      vk-tms)
         java -Ddd.agent.host=$DD_AGENT_HOST -Ddd.agent.port=8126 $JAVA_OPTS -Dlogstash.host= -Dlogstash.port= -Dtms.log4j.dir=$tms_log4j_dir -jar $jarfiles_path"tms.jar" --spring.config.additional-location=application.properties
       ;;
      vk-ekyc-dash)
         java -Ddd.agent.host=$DD_AGENT_HOST -Ddd.agent.port=8126 $JAVA_OPTS -Dlogstash.host= -Dlogstash.port= -Dserver.ssl.key-store=/data2/httpd-config/httpd-config-from-poc/conf.d/certificate.p12 -Dserver.ssl.key-store-password=123456 -Dserver.ssl.keyStoreType=PKCS12 -Dserver.sll.keyAlias=1 -Deureka.instance.nonSecurePortEnabled=false -Deureka.instance.securePortEnabled=true -jar $deployed_jarfiles --spring.config.additional-location=application.properties
       ;;
      vk-fbs-data)
         java -Ddd.agent.host=$DD_AGENT_HOST -Ddd.agent.port=8126 $JAVA_OPTS -Dlogstash.host= -Dspring.profiles.active=no.auth,sboot-rabbit-release,jdbc -Dlogstash.port= -Dtms.log4j.dir=$tms_log4j_dir -jar $jarfiles_path"fbs-data.jar" --spring.config.additional-location=application.properties
       ;;
      vk-threat-intel)
         java -Ddd.agent.host=$DD_AGENT_HOST -Ddd.agent.port=8126 $JAVA_OPTS -Dlogstash.host= -Dlogstash.port=  -jar $jarfiles_path"threat-intel.jar" --spring.config.additional-location=application.properties
       ;;
      vk-vos-dashboard)
         java -Ddd.agent.host=$DD_AGENT_HOST -Ddd.agent.port=8126 $JAVA_OPTS -Dlogstash.host= -Dlogstash.port=  -jar $jarfiles_path"vos-dashboard.jar" --spring.config.additional-location=application.properties
       ;;
      vk-csss-kms)
         java -Ddd.agent.host=$DD_AGENT_HOST -Ddd.agent.port=8126 $JAVA_OPTS -Dlogstash.host= -Dlogstash.port=  -jar $jarfiles_path"csss-kms.jar" --spring.config.additional-location=application.properties
       ;; 
      vk-auth-server)
         java -Ddd.agent.host=$DD_AGENT_HOST -Ddd.agent.port=8126 $JAVA_OPTS -Dlogstash.host= -Dlogstash.port=  -jar $jarfiles_path"auth-server.jar" --spring.config.additional-location=application.properties
       ;;
      vk-troubleshooting-logs)
         java -Ddd.agent.host=$DD_AGENT_HOST -Ddd.agent.port=8126 $JAVA_OPTS -Dlogstash.host= -Dlogstash.port=  -jar $jarfiles_path"troubleshooting-logs.jar" --spring.config.additional-location=application.properties
       ;;
      vk-config-dashboard)
         java -Ddd.agent.host=$DD_AGENT_HOST -Ddd.agent.port=8126 $JAVA_OPTS -Dlogstash.host= -Dlogstash.port=  -jar $jarfiles_path"config-dashboard.jar" --spring.config.additional-location=application.properties
       ;; 
      *)
        exec -a $serviceName java -Ddd.agent.host=$DD_AGENT_HOST -Ddd.agent.port=8126 $JAVA_OPTS -Dlogstash.host= -Dlogstash.port= -jar $deployed_jarfiles --spring.config.additional-location=application.properties
       ;;
    esac
}

start() {
    serviceName=$1

    if [ "$serviceName" = "" ] ; then
        echo "Please input service name. eg: run.sh start [service-name]"
        display_services
        exit 1
    elif [ "$serviceName" == "all" ] ; then
        start_all
    else
        start_service $serviceName
    fi
}

stop_all() {

  echo "STOP all the services...."
  pkill -9 -f "^vk-registry"
  pkill -9 -f "^vk-gateway"
  pkill -9 -f "^vk-audit"
  pkill -9 -f "^vk-vos-dashboard"
  pkill -9 -f "^vk-csss-kms"
  pkill -9 -f "^vk-admin"
  pkill -9 -f "^vk-ekyc-cust"
  pkill -9 -f "^vk-ekyc-regn"
  pkill -9 -f "^vk-ekyc-scor"
  pkill -9 -f "^vk-ekyc-dash"
  pkill -9 -f "^vk-ekyc-data"
  pkill -9 -f "^vk-config"
  pkill -9 -f "^vk-provision"
  pkill -9 -f "^vk-vtap"
  pkill -9 -f "^vk-vtrack"
  pkill -9 -f "^vk-asp"
  pkill -9 -f "^vk-smp"
  pkill -9 -f "^vk-tms"
  pkill -9 -f "^vk-batchloader"
  pkill -9 -f "^vk-varchive"
  pkill -9 -f "^vk-ekyc-pass"
  pkill -9 -f "^vk-cert-batch"
  pkill -9 -f "^vk-auth-server"
  pkill -9 -f "^vk-troubleshooting-logs"
  pkill -9 -f "^vk-config-dashboard"
}

stop_service() {
    serviceName=$1
    echo "Stop Service" $serviceName
    pkill -9 -f "^"$serviceName
}

stop() {
    serviceName=$1

    if [ "$serviceName" = "" ] ; then
        echo "Please input service name. eg: run.sh stop [service-name]"
        display_services
        exit 1
    elif [ "$serviceName" == "all" ] ; then
        stop_all
    else
        stop_service $serviceName
    fi
}

restart_service() {
    serviceName=$1
    stop_service $serviceName
    sleep 10s
    start_service $serviceName
}

restart() {
    serviceName=$1

    if [ "$serviceName" = "" ] ; then
        echo "Please input service name. eg: run.sh restart [service-name]"
        display_services
        exit 1
    elif [ "$serviceName" == "all" ] ; then
        stop all
        sleep 10s
        start all
    else
        restart_service $serviceName
    fi
}

if [ "$1" == "" ] ; then
    display_help
fi

case "$1" in
  -h)
    display_help
    ;;
  ls)
    display_services
    ;;
  start)
    start $2 # calling start()
    ;;
  stop)
    stop $2 # calling stop()
    ;;
  restart)
    restart $2
    ;;
  *)
  display_help
    ;;
esac
