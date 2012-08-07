#!/bin/sh


SCRIPT_PATH=`dirname $0`
cd $SCRIPT_PATH
CURRENT_DIR=`pwd`
export DCSDK_HOME="$CURRENT_DIR/.."

start_jar_found(){
	JETTY_OPTS="-Dfile.encoding=GBK -jar $START_JAR  $DCSDK_HOME/conf/jetty.xml"
	if [ "$JAVA_OPTS" ];then
		JETTY_OPTS="$JAVA_OPTS $JETTY_OPTS"
	fi
	cd $JETTY_HOME
	echo "$JETTY_OPTS"
	$JAVA_HOME/bin/java $JETTY_OPTS
}

java_found(){
	JETTY_HOME=$DCSDK_HOME/lib/jetty
	JAVA_OPTS="$JAVA_OPTS -DDCSDK_HOME=$DCSDK_HOME"
	JAVA_OPTS="$JAVA_OPTS -Dmain.class=com.taobao.tae.sdk.platform.Main"
	JAVA_OPTS="$JAVA_OPTS -DSTART=$DCSDK_HOME/conf/start.config"
	JAVA_OPTS="$JAVA_OPTS -Djava.io.tmpdir=$DCSDK_HOME/temp"	
	JAVA_OPTS="$JAVA_OPTS -Duser.home=$DCSDK_HOME/temp"
	JAVA_OPTS="$JAVA_OPTS -Duser.dir=$DCSDK_HOME/temp"
	
	JAVA_OPTS="$JAVA_OPTS -Dassets.host=a.tbcdn.cn"
	JAVA_OPTS="$JAVA_OPTS -Dkissy.uri=/s/kissy/1.2.0/kissy-min.js"
	JAVA_OPTS="$JAVA_OPTS -Dsystem.module.common.js.uri=/apps/taesite/platinum/scripts/common/mods/shop/"
	JAVA_OPTS="$JAVA_OPTS -Dcaja.service.uri=http://zxn.taobao.com/tbcajaService.htm"
	JAVA_OPTS="$JAVA_OPTS -Dsite.admin.root.url=http://siteadmin.taobao.com"	

	JAVA_OPTS="$JAVA_OPTS -Ddevelopment.mode=false"
	JAVA_OPTS="$JAVA_OPTS -Denable.sdk.mode=true"
	
	START_JAR=""
	for _START_JAR in $JETTY_HOME/start*.jar
	do
		START_JAR=$_START_JAR
	done
	if [ "$START_JAR" ];then
		start_jar_found
	else
		echo "start.jar was not found.  Check your SDK installation."
		exit 1
	fi
}

start(){
	TEMP_JAVA_HOME="$DCSDK_HOME/jre"
	if [ -x "$TEMP_JAVA_HOME/bin/java" ];then
	       JAVA_HOME=$TEMP_JAVA_HOME
	fi
	if [ -d "/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home" ];then
        JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home
    fi
	if [ -x "$JAVA_HOME/bin/java" ];then
		java_found
	else
		echo "JAVA_HOME does not point at a JDK or JRE.  Either set the JAVA_HOME environment variable or specify a JDK."
		exit 1
	fi
}

upgrade(){
	if [ -a "$DCSDK_HOME/upgrade_temp/upgrade.rdy" ];then
		rm -rf $DCSDK_HOME/conf
		rm -rf $DCSDK_HOME/db
		rm -rf $DCSDK_HOME/lib
		rm -rf $DCSDK_HOME/logs

		mv --force $DCSDK_HOME/upgrade_temp/upgrade_unziped/DC_SDK/conf  $DCSDK_HOME/conf
		mv --force $DCSDK_HOME/upgrade_temp/upgrade_unziped/DC_SDK/db  $DCSDK_HOME/db
		mv --force $DCSDK_HOME/upgrade_temp/upgrade_unziped/DC_SDK/lib  $DCSDK_HOME/lib
		mv --force $DCSDK_HOME/upgrade_temp/upgrade_unziped/DC_SDK/logs  $DCSDK_HOME/logs

		rm -rf $DCSDK_HOME/upgrade_temp
	fi
}

upgrade
start

