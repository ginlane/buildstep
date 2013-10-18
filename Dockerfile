FROM ubuntu:quantal
MAINTAINER Dmitri Vassilev "dmitri@ginlanemedia.com"

RUN apt-get update
RUN mkdir /build

ADD ./stack/ /build
ADD sources.list /etc/apt/sources.list.d/
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive /build/prepare
RUN rm -rf /var/lib/apt/lists/*

# ffmpeg
RUN apt-get install -y libavcodec-extra-53
RUN apt-get install -y libavcodec53 libavdevice53 libavfilter2 libavformat53
RUN apt-get install -y ffmpeg

# imagemagick 
RUN apt-get install -y ghostscript
RUN apt-get install -y libgs-dev gs-esp
RUN apt-get install -y imagemagick

RUN apt-get clean


