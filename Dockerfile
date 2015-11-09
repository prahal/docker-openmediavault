FROM debian:wheezy

MAINTAINER Ilya Kogan

ADD openmediavault.list /etc/apt/sources.list.d/
ADD omv-startup /usr/sbin/omv-startup

ENV DEBIAN_FRONTEND noninteractive

RUN echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections
RUN apt-get update -y; apt-get install openmediavault-keyring postfix locales -y --force-yes
RUN apt-get update -y; apt-get install openmediavault -y
RUN chmod +x /usr/sbin/omv-startup

ADD defaults/rrdcached /etc/default

EXPOSE 80 443

VOLUME /data

ENTRYPOINT /usr/sbin/omv-startup
