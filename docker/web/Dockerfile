FROM ubuntu:16.04
MAINTAINER Salmon Erasmus <sjerasmus@gmail.com>

# Get the PHP7 repository
RUN apt-get update -y \
    && apt-get install -y software-properties-common \
    && LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

# Install dependencies
RUN apt-get update -y \
    && apt-get install -y --allow-unauthenticated \
        apache2 \
        git \
        unzip \
        curl \
        vim \
        openssl \
        mcrypt \
        php7.1 \
        php7.1-mcrypt \
        php7.1-json \
        php7.1-zip \
        php7.1-gd \
        php7.1-gettext \
        php7.1-curl \
        php7.1-phar \
        php7.1-cli \
        php7.1-xml \
        php7.1-dom \
        php7.1-pdo \
        php7.1-mysqli \
        php7.1-sqlite3 \
        php7.1-ctype \
        php7.1-mbstring \
        php7.1-xmlwriter \
        php7.1-tokenizer \
        php7.1-simplexml \
        python-yaml \
        python-pip \
        python-dev \
        build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y sudo

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add the application files to the image
RUN mkdir -p /var/www/web-app

# Configure apache
RUN a2enmod php7.1
RUN a2enmod ssl
RUN a2enmod rewrite
RUN a2enmod headers
RUN chown -R www-data:www-data /var/www/web-app
RUN chmod g+s /var/www/web-app

ENV APACHE_DOCUMENTROOT=/var/www/web-app/public
ENV APACHE_RUN_USER www-data
ENV APACHE_SERVERNAME=localhost
ENV APACHE_SERVERADMIN=admin@localhost
ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_GROUP=www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE=/var/run/apache2.pid
ENV APACHE_RUN_DIR=/var/run/apache2
ENV APACHE_LOCK_DIR=/var/lock/apache2

EXPOSE 80 443

WORKDIR /var/www/web-app

# Define default command.
CMD /usr/sbin/apache2 -D FOREGROUND