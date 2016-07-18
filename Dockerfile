FROM ubuntu:14.04
MAINTAINER Sergey Cherepanov <sergey@cherepanov.co>
COPY bin/* /usr/local/bin/
RUN chmod +x /usr/local/bin/*

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# Add user with 1000 UID
RUN adduser --uid 1000 --quiet --disabled-password -shell /bin/bash --home /home/web --gecos "User" web 
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD "run.sh"

