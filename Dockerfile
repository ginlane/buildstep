FROM ubuntu:quantal
MAINTAINER Dmitri Vassilev "dmitri@ginlanemedia.com"

RUN mkdir /build
ADD ./stack/ /build
ADD sources.list /etc/apt/sources.list.d/
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive /build/prepare

# dialog
RUN apt-get install -y dialog

# ffmpeg
RUN apt-get install -y libavcodec-extra-53
RUN apt-get install -y libavcodec53 libavdevice53 libavfilter2 libavformat53
RUN apt-get install -y ffmpeg

# imagemagick 
RUN apt-get install -y ghostscript
RUN apt-get install -y libgs-dev
RUN apt-get install -y imagemagick

# libmagic
RUN apt-get install -y libmagic-dev

# setup ssh
# Finally - we wanna be able to SSH in
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# add our key for ssh'ing to and from this container
RUN mkdir /root/.ssh && chmod 700 /root/.ssh
ADD http://localhost.com/public_key /root/.ssh/authorized_keys
ADD http://localhost.com/public_key /root/.ssh/id_rsa.pub
ADD http://localhost.com/private_key /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa
RUN chmod 400 /root/.ssh/authorized_keys && chown root. /root/.ssh/authorized_keys
# update ssh config to disable stricthostkeychecking
RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
EXPOSE 22 

RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean

CMD ["/usr/sbin/sshd", "-D"]