FROM alpine
LABEL maintainer="hackaday <hackaday@coz.moe>"

ENV LANG C.UTF-8

RUN apk add --update --no-cache transmission-daemon supervisor openssh

RUN set -ex \
        && mkdir -p /transmission/downloads \
        && mkdir -p /transmission/incomplete \
        && mkdir -p /etc/transmission-daemon

RUN set -ex \
        && ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa \
        && ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa \
        && mkdir -p /var/run/sshd

RUN echo 'root:root' | chpasswd

RUN set -ex \
        && sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
        && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

COPY src/ .

EXPOSE 22 9091 51413/tcp 51413/udp

ENV USERNAME admin
ENV PASSWORD password

WORKDIR /

CMD ["/usr/bin/supervisord", "-n"]