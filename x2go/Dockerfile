FROM ai-image.jd.com/develop-docker/base:0.0.2
MAINTAINER daquexian

USER root

ENV DEBIAN_FRONTEND noninteractive

RUN add-apt-repository ppa:x2go/stable && apt-get update && apt-get -o Acquire::http::proxy=false install -y openssh-server xubuntu-desktop xfonts-wqy pwgen && apt-get install -y x2goserver x2goserver-xsession && apt clean && su - dev -c "git clone https://github.com/powerline/fonts.git --depth=1 && cd fonts && ./install.sh && cd .. && rm -rf fonts" && mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && sed -i "s/#PasswordAuthentication/PasswordAuthentication/g" /etc/ssh/sshd_config && mkdir -p /tmp/.X11-unix && chmod 1777 /tmp/.X11-unix && sed -i "s/mesg n/tty -s \&\& mesg n/" /root/.profile

RUN echo "#! /bin/bash" >> /run.sh && echo "echo \"dev\" | sudo -S /usr/sbin/sshd -D" >> /run.sh && chmod +x /run.sh

ARG USERNAME
USER $USERNAME

CMD ["/run.sh"]
