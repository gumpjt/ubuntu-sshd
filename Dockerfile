FROM       ubuntu:22.04


RUN apt-get update

RUN apt-get install -y openssh-server cron net-tools lua5.4 liblua5.4 liblua5.4-dev vim sudo lrzsz zip unzip htop git autoconf autopoint gettext build-essential libmaxminddb-dev libncursesw5-dev libgeoip-dev rsync checkinstall zlib1g-dev libssl-dev cmake
RUN mkdir /var/run/sshd

RUN echo 'root:root' | chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*




RUN service ssh start


EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
