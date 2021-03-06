[![](https://img.shields.io/docker/stars/hkalinke/teamspeak3.svg)](https://hub.docker.com/r/hkalinke/teamspeak3 'DockerHub') [![](https://img.shields.io/docker/pulls/hkalinke/teamspeak3.svg)](https://hub.docker.com/r/hkalinke/teamspeak3 'DockerHub')

teamspeak3 sets up a container running the selected version of the teamspeak3 voice communication server.

### Usage

To run it:

    $ docker run -d  \
      --name teamspeak3 \
      --restart=always 
      -p 9987:9987/udp \
      -p 30033:30033 \
      -p 10011:10011 \
      -e TS3SERVER_LICENSE=accept \
      -v /some/data/dir:/home/teamspeak/data \
      hkalinke/teamspeak3
