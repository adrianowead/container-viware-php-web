#=======================#
# composer já instalado #
#=======================#
FROM composer:latest AS composer

#==============#
# imagem final #
#==============#
FROM ubuntu:20.04

LABEL maintainer="Adriano Maciel"

ARG WWWGROUP

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
    gnupg2 \
    gosu \
    curl \
    ca-certificates \
    zip \
    unzip \
    git \
    supervisor \
    sqlite3 \
    libcap2-bin \
    libpng-dev \
    python2 \
    vim \
    apache2 \
    libapache2-mod-fcgid \
    iputils-ping \
    apt-utils \
    software-properties-common \
    wget \
    unixodbc \
    unixodbc-dev \
    build-essential \
    libpng-dev \
    freetds-common \
    libsybdb5 \
    lsb-release \
    apt-transport-https

# instalando nodejs
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn

RUN apt-get install -y mysql-client \
    && apt-get install -y postgresql-client

#instalando o ODBC para SQL Server
#https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver15#ubuntu17
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update && \
    ACCEPT_EULA=Y apt-get -my install msodbcsql17
RUN ACCEPT_EULA=Y apt-get -my install mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"

RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update

RUN apt-get install -y \
    php7.4-pgsql \
    php7.4-imap \
    php7.4-bcmath \
    php7.4-pcov \
    php7.4-ldap \
    php7.4-xdebug \
    php7.4-curl \
    php7.4-dev \
    php7.4-decimal \
    php7.4-fpm \
    php7.4-gd \
    php7.4-gmp \
    php7.4-grpc \
    php7.4-http \
    php7.4-igbinary \
    php7.4-imagick \
    php7.4-inotify \
    php7.4-intl \
    php7.4-mbstring \
    php7.4-mcrypt \
    php7.4-memcache \
    php7.4-memcached \
    php7.4-msgpack \
    php7.4-mysql \
    php7.4-mysqlnd \
    php7.4-mongodb \
    php7.4-oauth \
    php7.4-odbc \
    php7.4-opcache \
    php7.4-pcov \
    php7.4-protobuf \
    php7.4-psr \
    php7.4-raphf \
    php7.4-readline \
    php7.4-redis \
    php7.4-soap \
    php7.4-sqlite3 \
    php7.4-swoole \
    php7.4-uuid \
    php7.4-xml \
    php7.4-xmlrpc \
    php7.4-xsl \
    php7.4-yaml \
    php7.4-zip \
    php7.4-zmq \
    php7.4-zstd

RUN apt-get install -y \
    php8.0-pgsql \
    php8.0-imap \
    php8.0-bcmath \
    php8.0-pcov \
    php8.0-ldap \
    php8.0-xdebug \
    php8.0-curl \
    php8.0-dev \
    php8.0-decimal \
    php8.0-fpm \
    php8.0-gd \
    php8.0-gmp \
    php8.0-grpc \
    php8.0-http \
    php8.0-igbinary \
    php8.0-imagick \
    php8.0-inotify \
    php8.0-intl \
    php8.0-mbstring \
    php8.0-mcrypt \
    php8.0-memcache \
    php8.0-memcached \
    php8.0-msgpack \
    php8.0-mysql \
    php8.0-mysqlnd \
    php8.0-mongodb \
    php8.0-oauth \
    php8.0-odbc \
    php8.0-opcache \
    php8.0-pcov \
    php8.0-protobuf \
    php8.0-psr \
    php8.0-raphf \
    php8.0-readline \
    php8.0-redis \
    php8.0-soap \
    php8.0-sqlite3 \
    php8.0-swoole \
    php8.0-uuid \
    php8.0-xml \
    php8.0-xmlrpc \
    php8.0-xsl \
    php8.0-yaml \
    php8.0-zip \
    php8.0-zmq \
    php8.0-zstd

# adicionando extensões à partir do PECL
RUN pecl update-channels

# PHP 7.4
RUN pecl -d php_suffix=7.4 install -f sqlsrv pdo_sqlsrv && \
  pecl uninstall -r sqlsrv pdo_sqlsrv

RUN printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php/7.4/mods-available/sqlsrv.ini && \
  printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/7.4/mods-available/pdo_sqlsrv.ini


# PHP 8.0
RUN pecl -d php_suffix=8.0 install -f sqlsrv pdo_sqlsrv && \
  pecl uninstall -r sqlsrv pdo_sqlsrv

RUN printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php/8.0/mods-available/sqlsrv.ini && \
  printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/8.0/mods-available/pdo_sqlsrv.ini

# PHP ALL
RUN phpenmod -v ALL -s ALL sqlsrv pdo_sqlsrv


RUN echo 'alias php8=/usr/bin/php8.0' >> ~/.bashrc
RUN echo 'alias php7=/usr/bin/php7.4' >> ~/.bashrc

RUN update-alternatives --set php /usr/bin/php8.0

# criando diretório para armazenar a chave ssh
RUN mkdir -p /root/.ssh \
    && chmod 0700 /root/.ssh

# aceitar a chave do servidor Azure
RUN ssh-keyscan -H ssh.dev.azure.com > /root/.ssh/known_hosts

# instalar composer a partir do outro container
COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN a2enmod rewrite \
    && a2enmod rewrite \
    && a2enmod proxy \
    && a2enmod proxy_http \
    && a2enmod proxy_ajp \
    && a2enmod proxy_fcgi \
    && a2enmod ssl \
    && a2enmod deflate \
    && a2enmod headers \
    && a2enmod proxy_balancer \
    && a2enmod proxy_connect \
    && a2enmod proxy_html \
    && a2enmod setenvif

COPY config/supervisord.conf /etc/supervisor/supervisord.conf
COPY config/supervisor-viware.conf /etc/supervisor/conf.d/viware.conf

# apache
COPY config/default-vhost.conf /etc/apache2/sites-enabled/000-default.conf

# PHP FPM
COPY config/pool_7.conf /etc/php/7.4/fpm/pool.d/pool_7.conf
COPY config/pool_8.conf /etc/php/8.0/fpm/pool.d/pool_8.conf

RUN mkdir -p /run/php

# Clean up
RUN apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "127.0.0.1 viware-base-php" >> /etc/hosts

EXPOSE 80

ENTRYPOINT ["supervisord"]
