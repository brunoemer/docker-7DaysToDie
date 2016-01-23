#!/bin/bash

cd /home/steam
sed -i 's/steamuser="username"/steamuser=REPLACE_USER/' sdtdserver
sed -i 's/steampass="password"/steampass=REPLACE_PASSWORD/' sdtdserver
sed -i "s/steamuser=REPLACE_USER/steamuser='$STEAM_USERNAME'/" sdtdserver
sed -i "s/steampass=REPLACE_PASSWORD/steampass='$STEAM_PASSWORD'/" sdtdserver
yes y|./sdtdserver install


# add variables values from docker environment to SD2D config file before replacing default one and starting server.
# example:  if variable MaxSpawnedZombies=100 is defined in enviroment, it will change the config default value to 100.
# this variables can be passed when starting docker container with flag
# 	--env MaxSpawnedZombies=100
for var in `env|grep -o .*=|sed 's/=//'`;
do 
	SD2D=`grep $var ./serverconfig_template.xml`;
	if ! [ x"${SD2D}" = "x" ];
	 then
		current_value=`echo $SD2D|grep -Eo "value=\".*\""`;
		new_value=`echo "value=\"${!var}\""`;
		
	#	echo $current_value
	#	echo $new_value
	#	echo $SD2D 

		new_SD2D=`echo $SD2D|sed "s/${current_value}/${new_value}/"`
		
	#	echo $new_SD2D		
		sed -i.bak "s#${SD2D}#${new_SD2D}#g" ./serverconfig_template.xml
	fi
done



cp -v ./serverconfig_template.xml ./serverfiles/sdtd-server.xml
bash /run.sh
