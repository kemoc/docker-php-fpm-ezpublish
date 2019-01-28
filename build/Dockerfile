FROM php:5.6-fpm-stretch
MAINTAINER Radek Z
# https://github.com/wodby/php/blob/master/5.6/Dockerfile

# https://hub.docker.com/_/php/
# important: without trailling '/'
ENV PROJECTMAPPINGFOLDER="/var/www/project"

# Update sources
RUN apt update -y

RUN apt install -y apt-utils acl

RUN apt install -y bcrypt

# Install unzip
RUN apt install -y zip unzip

# Install Midnight Commander, Vim, Nano
RUN apt install -y vim nano wget

#RUN apt install -y mysql-client
RUN apt install -y mariadb-client=10.1.37-0+deb9u1

RUN apt install -y findutils \
    libgmp-dev \
    libgmp-ocaml \
    libicu-dev \
    less \
    libbz2-1.0 \
    libevent-2.0-5 \
    imagemagick \
    jpegoptim \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-turbo-progs \
    libldap-2.4-2 \
    libxslt1.1 \
    make \
    libssl1.0.2

# Install NodeJS
#RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
#RUN apt-get install -y nodejs

# Install Composer
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
#RUN composer --version

# Install GRUNT
#RUN npm install -g grunt-cli


RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

# Install xdebug
#RUN pecl install xdebug
#RUN docker-php-ext-enable xdebug
#RUN echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "display_startup_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "display_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.idekey=\"PHPSTORM\"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.remote_port=9001" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Add custom Apache configs
#RUN rm /etc/apache2/sites-available/000-default.conf
#ADD ./vhost.conf /etc/apache2/sites-available/000-default.conf
#ADD ./project/apache2/rewrites.conf /etc/apache2/includes/project-rewrites.conf
#ADD ./project/apache2/log.conf /etc/apache2/includes/project-log.conf
#ADD ./project/apache2/rewrites.conf /etc/apache2/includes/project-rewrites.conf
#ADD ./project/apache2/cache.conf /etc/apache2/includes/project-cache.conf

# zip
RUN apt install -y zlib1g-dev
RUN apt install -y libxml2-dev
# Install XSL
RUN apt install -y libxslt-dev

# Install PHP modules
RUN apt install -y curl
RUN apt install -y libcurl3
RUN apt install -y libcurl3-dev
RUN apt install -y zlib1g-dev libicu-dev g++
RUN apt install -y libcurl4-openssl-dev
RUN docker-php-ext-install curl
RUN docker-php-ext-enable curl

#RUN apt install -y libmcrypt-dev
#RUN docker-php-ext-install mcrypt
# or:?
#RUN apt install -y libmcrypt-dev
#RUN docker-php-ext-install -j$(nproc) mcrypt
#RUN docker-php-ext-enable mcrypt
RUN apt install -y bzip2
RUN apt install -y libbz2-dev

RUN apt-get update && apt-get install -y libc-client-dev libkrb5-dev
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap

RUN apt-get install -y libldb-dev libldap2-dev
#RUN docker-php-ext-install ldap
RUN docker-php-ext-install \
        bcmath \
        bz2 \
        calendar \
        exif \
        intl \
        mysqli \
        opcache \
        pcntl \
        pdo \
        pdo_mysql \
        sockets \
        xmlrpc \
        xml \
        xsl \
        mbstring \
        zip

# Install SOAP
RUN docker-php-ext-install -j$(nproc) soap
RUN docker-php-ext-enable soap

RUN docker-php-ext-install -j$(nproc) iconv
RUN docker-php-ext-enable iconv

#apt install -y libz-dev libmemcached-dev memcached
#pecl install memcached-2.2.0
#echo "extension=memcached.so" > /usr/local/etc/php/conf.d/memcached.ini

RUN apt install -y libjpeg-dev
# Install GD
RUN docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/
#RUN NPROC=$(getconf _NPROCESSORS_ONLN); \

RUN docker-php-ext-install -j$(nproc) gd;

# PECL extensions
#RUN pecl config-set php_ini "${PHP_INI_DIR}/php.ini";

RUN pecl install apcu-4.0.11
#RUN echo "extension=apcu.so" > /usr/local/etc/php/conf.d/apcu.ini
RUN docker-php-ext-enable apcu


# Install ImageMagick
RUN apt install -y \
    libmagickwand-dev \
    --no-install-recommends
RUN pecl install imagick
RUN docker-php-ext-enable imagick


# Install PHP "pdo" extension with "mysql", "pgsql", "sqlite" drivers – http://php.net/manual/pl/book.pdo.php RUN apt-get install -y libpq-dev libsqlite3-dev
#RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
#RUN docker-php-ext-install pdo pdo_mysql pgsql pdo_pgsql pdo_sqlite

# Setup timezone
#RUN TZ=Europe/Warsaw
#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Java for Solr
#RUN apt-get install -y openjdk-8-jdk

COPY entrypoint.bash /entrypoint.bash
RUN chmod a+x /entrypoint.bash
# https://github.com/docker/docker.github.io/issues/6142
ENTRYPOINT ["docker-php-entrypoint", "/entrypoint.bash"]

# Set workdir
WORKDIR ${PROJECTMAPPINGFOLDER}

# Cleanup the image
RUN rm -rf /var/lib/apt/lists/* /tmp/*

# https://github.com/docker/docker.github.io/issues/6142
CMD ["php-fpm"]
