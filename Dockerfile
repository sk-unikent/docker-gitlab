FROM php:5.6-cli
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
        libmcrypt-dev \
        mysql-client \
        git-core \
        unzip \
        openssh-client \
        libmemcached-dev \
        locales \
        libicu-dev \
        libcurl4-openssl-dev \
        libxml2-dev \
        nodejs
RUN echo "en_AU ISO-8859-1" >> /etc/locale.gen \
    echo "en_AU.UTF-8 UTF-8" >> /etc/locale.gen \
    locale-gen
RUN pecl install memcached
RUN pecl install intl
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) curl gd iconv mcrypt mysqli mbstring dom simplexml soap xml xmlrpc zip
RUN docker-php-ext-enable memcached intl curl
