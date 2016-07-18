# docker-sshd
Containerized sshd

### Usage
```
docker run -d --restart=always \
-p 10022:22 \
-v /var/www:/home/web/www \
-e "ROOT_PASS=root1234" \
-e "USER_PASS=web1234" \
scherepanov/sshd
```
