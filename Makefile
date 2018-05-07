all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""  This is merely a base image for usage read the README file
	@echo ""   1. make run       - build and run docker container

build: builddocker beep

run: steam_username steam_password builddocker rundocker beep

rundocker:
	@docker run --name=7daystodie \
	--cidfile="cid" \
	-p 26900:26900/tcp \
	-p 26900:26900/udp \
	-p 26901:26901/udp \
	-p 26902:26902/udp \
	-p 8080:8080/tcp \
	-p 8081:8081/tcp \
	--env GameName=NuvolaHost \
	--env ServerName="NuvolaHost 7 Days To Die Host" \
	-v /var/run/docker.sock:/run/docker.sock \
	-v $(shell which docker):/bin/docker \
	-t thalhalla/7daystodie

builddocker:
	/usr/bin/time -v docker build -t thalhalla/7daystodie .

beep:
	@echo "beep"
	@aplay /usr/share/sounds/alsa/Front_Center.wav

kill:
	@docker kill `cat cid`

rm-steamer:
	rm  steamer.txt

rm-name:
	rm  name

rm-image:
	@docker rm `cat cid`
	@rm cid

cleanfiles:
	rm name
	rm steam_username
	rm steam_password

rm: kill rm-image

clean: cleanfiles rm

enter:
	docker exec -i -t `cat cid` /bin/bash

steam_username:
	@while [ -z "$$STEAM_USERNAME" ]; do \
		read -r -p "Enter the steam username you wish to associate with this container [STEAM_USERNAME]: " STEAM_USERNAME; echo "$$STEAM_USERNAME">>steam_username; cat steam_username; \
	done ;

steam_guard_code:
	@while [ -z "$$STEAM_GUARD_CODE" ]; do \
		read -r -p "Enter the steam guard code you wish to associate with this container [STEAM_GUARD_CODE]: " STEAM_GUARD_CODE; echo "$$STEAM_GUARD_CODE">>steam_guard_code; cat steam_guard_code; \
	done ;

steam_password:
	@while [ -z "$$STEAM_PASSWORD" ]; do \
		read -r -p "Enter the steam password you wish to associate with this container [STEAM_PASSWORD]: " STEAM_PASSWORD; echo "$$STEAM_PASSWORD">>steam_password; cat steam_password; \
	done ;

