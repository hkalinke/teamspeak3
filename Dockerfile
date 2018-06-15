#base image
FROM ubuntu:16.04

# installing version
ENV TS3_VERSION 3.2.0

# install TS3
RUN apt-get update -q \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -qy bzip2 wget nmap \
	&& useradd -u 1000 teamspeak \
	&& mkdir -p /home/teamspeak \
	&& wget -q -O /home/teamspeak/ts3server.tar.bz2 http://dl.4players.de/ts/releases/$TS3_VERSION/teamspeak3-server_linux_amd64-$TS3_VERSION.tar.bz2 \
	&& tar --directory home/teamspeak -xjf /home/teamspeak/ts3server.tar.bz2 \
	&& rm /home/teamspeak/ts3server.tar.bz2 \
	&& mkdir -p /home/teamspeak/data/logs \
	&& mkdir -p /home/teamspeak/data/files \
	&& mv /home/teamspeak/teamspeak3-server_linux_amd64 /home/teamspeak/ts3server \
	&& ln -s /home/teamspeak/data/ts3server.sqlitedb /home/teamspeak/ts3server/ts3server.sqlitedb \
	&& chown -R teamspeak /home/teamspeak \
	&& rm -rf /var/lib/apt/lists/*
	
# execute as teamspeak user
USER teamspeak

#entrypoint for teamspeak server
ENTRYPOINT ["/home/teamspeak/ts3server/ts3server_minimal_runscript.sh"]

# default parameters for entrypoint
CMD ["inifile=/home/teamspeak/data/ts3server.ini", "logpath=/home/teamspeak/data/logs", "licensepath=/home/teamspeak/data/", "query_ip_whitelist=/home/teamspeak/data/query_ip_whitelist.txt", "query_ip_blacklist=/home/teamspeak/data/query_ip_blacklist.txt"]

# ports for TS3, files, serverquery
EXPOSE 9987/udp 30033 10011
	
