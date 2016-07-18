#!/usr/bin/env bash
if [[ ! -z ${USER_PASS} ]]; then
  echo "web:"${USER_PASS} | chpasswd
fi

if [[ ! -z ${ROOT_PASS} ]]; then
  echo "root:"${ROOT_PASS} | chpasswd
fi

/usr/sbin/sshd -D 


