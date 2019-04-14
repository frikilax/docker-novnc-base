### frikilax/novnc-base
### v1

FROM phusion/baseimage:0.11
EXPOSE 6080/tcp

USER root
ENV DISPLAY=:0
ENTRYPOINT ["/sbin/my_init"]

# Update and install dependencies
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git wget python x11-xkb-utils libxkbcommon0 ratpoison
RUN git clone https://github.com/novnc/noVNC /home/noVNC/
RUN git clone https://github.com/novnc/websockify /home/noVNC/utils/websockify
RUN cp /home/noVNC/vnc.html /home/noVNC/index.html

# Install TigerVNC 1.9.0
RUN wget https://bintray.com/tigervnc/stable/download_file?file_path=tigervnc-1.9.0.x86_64.tar.gz -O tigervnc-1.9.0.x86_64.tar.gz \
&& tar xzf tigervnc-1.9.0.x86_64.tar.gz \
&& cd tigervnc-1.9.0.x86_64 \
&& tar czf usr.tgz usr \
&& tar xzf usr.tgz -C /

# Create services for base-image to launch
RUN mkdir /etc/service/xvnc
RUN echo "#!/bin/sh\nXvnc \$DISPLAY -localhost -SecurityTypes None > /var/log/xvnc.log 2>&1" > /etc/service/xvnc/run
RUN chmod u+x /etc/service/xvnc/run

RUN mkdir /etc/service/novnc
RUN echo "#!/bin/sh\n/home/noVNC/utils/launch.sh --vnc localhost:5900 > /var/log/novnc.log 2>&1" > /etc/service/novnc/run
RUN chmod u+x /etc/service/novnc/run

RUN mkdir /etc/service/ratpoison
RUN echo "#!/bin/sh\nratpoison > /var/log/ratpoison.log 2>&1" > /etc/service/ratpoison/run
RUN chmod u+x /etc/service/ratpoison/run

# APT cleanup
RUN apt-get autoremove --purge -y wget git
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
