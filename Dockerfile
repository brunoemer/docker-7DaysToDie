FROM joshuacox/steamer
MAINTAINER James S. Moore <james 'at' webtechhq com>

USER root
ENV 7DTDocker 2015080403

# expose 7DaysToDie ports
EXPOSE 26900
EXPOSE 26901
EXPOSE 9080
EXPOSE 9081

# override these variables in your Dockerfile
ENV STEAM_USERNAME anonymous
ENV STEAM_PASSWORD ' '
ENV STEAM_GUARD_CODE ' '

# and override this file with the command to start your server
USER root
RUN echo 'new-session' >> ~/.tmux.conf

# import custom 7DTD config
ADD ./serverconfig_template.xml /home/steam/serverfiles/sdtd-server.xml
ADD ./run.sh /run.sh
RUN chmod 755 /run.sh

# Override the default start.sh
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh
RUN gpasswd -a steam tty

# setup steam user / default configs
USER steam
RUN echo 'new-session' >> ~/.tmux.conf
WORKDIR /home/steam
RUN wget http://gameservermanagers.com/dl/sdtdserver
RUN chmod +x sdtdserver

ENTRYPOINT ["/start.sh"]
