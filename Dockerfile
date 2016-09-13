FROM ubuntu:14.04

RUN export DEBIAN_FRONTEND=noninteractive; locale-gen en en_US en_US.UTF-8 && dpkg-reconfigure locales
RUN apt-get update && apt-get install -y openssh-server && apt-get clean && mkdir /var/run/sshd

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
EXPOSE 22
CMD ["/usr/sbin/sshd -D"]
