FROM ubuntu:12.04
MAINTAINER Max Gonzih <gonzih at gmail dot com>

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install lib32gcc1 lib32z1 lib32ncurses5 lib32bz2-1.0 lib32asound2 lib32stdc++6 libcurl3-gnutls:i386 wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    adduser --gecos "" tf2

USER tf2
ENV HOME /home/tf2
ENV SERVER $HOME/hlserver

RUN mkdir -p $SERVER/tf2 && \
    wget -O - http://media.steampowered.com/client/steamcmd_linux.tar.gz | tar -C $SERVER -xvz

ADD ./tf2_ds.txt $HOME/tf2_ds.txt
ADD ./tf2.sh $HOME/tf2.sh

EXPOSE 27015/udp 27015

WORKDIR $HOME

ENTRYPOINT ["/home/tf2/tf2.sh"]
CMD ["+sv_pure", "1", "+mapcycle", "mapcycle_quickplay_payload.txt", "+map", "pl_badwater", "+maxplayers", "24"]
