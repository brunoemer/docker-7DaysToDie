FROM joshuacox/steamer
MAINTAINER James S. Moore <james 'at' webtechhq com>

USER root
ENV 7DTDocker 2015080403

# expose 7DaysToDie ports
EXPOSE 26900
EXPOSE 26901
EXPOSE 8080
EXPOSE 8081

# override these variables in your Dockerfile
ENV STEAM_USERNAME anonymous
ENV STEAM_PASSWORD ''
ENV STEAM_GUARD_CODE ' '

#timezone
RUN echo "America/Sao_Paulo" | sudo tee /etc/timezone
RUN sudo dpkg-reconfigure --frontend noninteractive tzdata

#packages
RUN apt-get -y update
RUN apt-get install -y file bsdmainutils python bzip2 unzip bc tmux telnet expect
RUN apt-get install -y curl
RUN apt-get install -y less nano

RUN echo 'deb http://http.debian.net/debian/ jessie main contrib non-free'>>/etc/apt/sources.list
RUN dpkg --add-architecture i386
RUN apt-get -y update
RUN apt-get install -y libstdc++6:i386
RUN rm -rf /var/lib/apt/lists/*

# and override this file with the command to start your server
USER root
RUN echo 'new-session' >> ~/.tmux.conf

# import custom 7DTD config
ADD ./serverconfig_template.xml /home/steam/serverconfig_template.xml
ADD ./run.sh /run.sh
RUN chmod 755 /run.sh

# Override the default start.sh
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh
RUN gpasswd -a steam tty
RUN chown -R steam:steam /home/steam 

# setup steam user / default configs
USER steam
RUN echo 'new-session' >> ~/.tmux.conf
WORKDIR /home/steam
RUN wget http://gameservermanagers.com/dl/sdtdserver
RUN chmod +x sdtdserver

ENTRYPOINT ["/start.sh"]
