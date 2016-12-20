FROM djocker/sshd

RUN apt-get -qqy update \
&& apt-get install -qqy software-properties-common python-software-properties \
&& add-apt-repository -y ppa:ondrej/php \
&& apt-get -qqy update 

# Install base packages
RUN apt-get install -qqy apt-transport-https ca-certificates vim make git-core sudo wget curl procps \
python-setuptools mcrypt mysql-client zip unzip redis-tools

# Install php
RUN apt-get install -qqy --no-install-recommends php5.6-fpm php5.6-cli php5.6-common php5.6-dev \
php5.6-mysql php5.6-curl php5.6-gd php5.6-mcrypt php5.6-sqlite php5.6-xmlrpc php5.6-ldap \
php5.6-xsl php5.6-intl php5.6-soap php5.6-mbstring php5.6-zip php5.6-bz2 php5.6-redis

# Install composer
RUN (curl -sS https://getcomposer.org/installer | php) \
&& mv composer.phar /usr/local/bin/composer

# Install composer packages
RUN composer global require "fxp/composer-asset-plugin:~1.2"

# Install node.js
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - \
&& apt-get install -qqy nodejs

# Install ruby-compass
RUN apt-get install -yqq ruby-compass

# Install less compiler
RUN apt-get install -yqq node-less 

# Install yui-compressor
RUN apt-get install -yqq yui-compressor
