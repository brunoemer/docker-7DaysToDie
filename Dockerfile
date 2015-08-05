FROM joshuacox/steamer
MAINTAINER Josh Cox <josh 'at' webhosting coop>

USER root
ENV 7DTDocker 2015080403

# expose 7DaysToDie ports
EXPOSE 25000
EXPOSE 25001
EXPOSE 25002
EXPOSE 25003
EXPOSE 25004
EXPOSE 25005

# override these variables in your Dockerfile
ENV STEAM_USERNAME anonymous
ENV STEAM_PASSWORD ' '
ENV STEAM_GUARD_CODE ' '

# and override this file with the command to start your server
USER root
RUN echo 'new-session' >> ~/.tmux.conf
ADD ./run.sh /run.sh
RUN chmod 755 /run.sh

# Override the default start.sh
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh
RUN gpasswd -a steam tty

USER steam
RUN echo 'new-session' >> ~/.tmux.conf
WORKDIR /home/steam
RUN wget http://gameservermanagers.com/dl/sdtdserver
RUN chmod +x sdtdserver

ENTRYPOINT ["/start.sh"]
