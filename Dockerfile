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
    php7.3-pgsql \
    php7.3-imap \
    php7.3-bcmath \
    php7.3-pcov \
    php7.3-ldap \
    php7.3-xdebug \
    php7.3-curl \
    php7.3-dev \
    php7.3-decimal \
    php7.3-fpm \
    php7.3-gd \
    php7.3-gmp \
    php7.3-grpc \
    php7.3-http \
    php7.3-igbinary \
    php7.3-imagick \
    php7.3-inotify \
    php7.3-intl \
    php7.3-mbstring \
    php7.3-mcrypt \
    php7.3-memcache \
    php7.3-memcached \
    php7.3-msgpack \
    php7.3-mysql \
    php7.3-mysqlnd \
    php7.3-mongodb \
    php7.3-oauth \
    php7.3-odbc \
    php7.3-opcache \
    php7.3-pcov \
    php7.3-protobuf \
    php7.3-psr \
    php7.3-raphf \
    php7.3-readline \
    php7.3-redis \
    php7.3-soap \
    php7.3-sqlite3 \
    php7.3-swoole \
    php7.3-uuid \
    php7.3-xml \
    php7.3-xmlrpc \
    php7.3-xsl \
    php7.3-yaml \
    php7.3-zip \
    php7.3-zmq \
    php7.3-zstd

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

RUN apt-get install -y \
    php8.1-pgsql \
    php8.1-imap \
    php8.1-bcmath \
    php8.1-pcov \
    php8.1-ldap \
    php8.1-xdebug \
    php8.1-curl \
    php8.1-dev \
    php8.1-decimal \
    php8.1-fpm \
    php8.1-gd \
    php8.1-gmp \
    php8.1-grpc \
    php8.1-http \
    php8.1-igbinary \
    php8.1-imagick \
    php8.1-inotify \
    php8.1-intl \
    php8.1-mbstring \
    php8.1-mcrypt \
    php8.1-memcache \
    php8.1-memcached \
    php8.1-msgpack \
    php8.1-mysql \
    php8.1-mysqlnd \
    php8.1-mongodb \
    php8.1-oauth \
    php8.1-odbc \
    php8.1-opcache \
    php8.1-pcov \
    php8.1-protobuf \
    php8.1-psr \
    php8.1-raphf \
    php8.1-readline \
    php8.1-redis \
    php8.1-soap \
    php8.1-sqlite3 \
    php8.1-swoole \
    php8.1-uuid \
    php8.1-xml \
    php8.1-xmlrpc \
    php8.1-xsl \
    php8.1-yaml \
    php8.1-zip \
    php8.1-zmq \
    php8.1-zstd

# adicionando extensões à partir do PECL
RUN pecl update-channels

# PHP 7.3
RUN pecl -d php_suffix=7.3 install -f sqlsrv pdo_sqlsrv && \
  pecl uninstall -r sqlsrv pdo_sqlsrv

RUN printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php/7.3/mods-available/sqlsrv.ini && \
  printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/7.3/mods-available/pdo_sqlsrv.ini

# PHP 7.4
RUN pecl -d php_suffix=7.4 install -f sqlsrv pdo_sqlsrv && \
  pecl uninstall -r sqlsrv pdo_sqlsrv

RUN printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php/7.4/mods-available/sqlsrv.ini && \
  printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/7.4/mods-available/pdo_sqlsrv.ini

# PHP 8.0
RUN pecl -d php_suffix=8.0 install -f sqlsrv pdo_sqlsrv && \
  pecl uninstall -r sqlsrv pdo_sqlsrv

# PHP 8.1
RUN pecl -d php_suffix=8.1 install -f sqlsrv pdo_sqlsrv && \
  pecl uninstall -r sqlsrv pdo_sqlsrv

RUN printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php/8.0/mods-available/sqlsrv.ini && \
  printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/8.0/mods-available/pdo_sqlsrv.ini

# PHP ALL
RUN phpenmod -v ALL -s ALL sqlsrv pdo_sqlsrv

RUN echo 'alias php81=/usr/bin/php8.1' >> ~/.bashrc
RUN echo 'alias php8=/usr/bin/php8.0' >> ~/.bashrc
RUN echo 'alias php7=/usr/bin/php7.4' >> ~/.bashrc
RUN echo 'alias php7=/usr/bin/php7.3' >> ~/.bashrc

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
COPY config/pool_73.conf /etc/php/7.3/fpm/pool.d/pool_73.conf
COPY config/pool_74.conf /etc/php/7.4/fpm/pool.d/pool_74.conf
COPY config/pool_80.conf /etc/php/8.0/fpm/pool.d/pool_80.conf
COPY config/pool_81.conf /etc/php/8.1/fpm/pool.d/pool_81.conf

RUN mkdir -p /run/php

# Clean up
RUN apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "127.0.0.1 viware-base-php" >> /etc/hosts

EXPOSE 80

ENTRYPOINT ["supervisord"]
