#!/usr/bin/env bash
if [[ ! -z ${USER_NAME} ]]; then
  if [[ "www-data" == ${USER_NAME} ]]; then
    chsh -s /bin/bash ${USER_NAME}
  else
    adduser --uid ${USER_UID-1000} --gid ${USER_GID-1000} --quiet --disabled-password --shell /bin/bash --home /home/web --gecos "User" ${USER_NAME} 
  fi
  
  if [[ ${#USER_PASS} -gt 0 ]]; then
    echo ${USER_NAME}":"${USER_PASS} | chpasswd
  fi
  [[ -f $(echo ~${USER_NAME})/.ssh/authorized_keys ]] && chown ${USER_UID-1000}:${USER_GID-1000} $(echo ~${USER_NAME})/.ssh/authorized_keys
fi

if [[ ! -z ${ROOT_PASS} ]]; then
  sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
  echo "root:"${ROOT_PASS} | chpasswd
  [[ -f $(echo ~root)/.ssh/authorized_keys ]] && chown root:root $(echo ~root)/.ssh/authorized_keys
fi

exec $@;
