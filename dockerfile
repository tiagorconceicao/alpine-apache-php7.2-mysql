FROM alpine:3.9
LABEL maintainer =  "Tiago R Conceição <tiracotech@gmail.com>"
LABEL description = "Alpine based image with apache2 and php7.2"

RUN apk add --update --no-cache bash \
				nano \
				curl \
				curl-dev \
				php7 \
				php7-intl \
				php7-apache2 \
				php7-session \
				php7-sqlite3 \
				php7-tokenizer \
				php7-dba \
				php7-opcache \
				php7-fpm \
				php7-gd \
				php7-gmp \
				php7-curl \
				php7-openssl \
				php7-mysqlnd \
				php7-mysqli \
				php7-pdo_mysql \
				php7-sysvsem \
				php7-pdo \
				php7-pear \
				php7-phpdbg \
				php7-pcntl \
				php7-common \
				php7-xsl \
				php7-enchant \
				php7-pspell \
				php7-snmp \
				php7-doc \
				php7-dev \
				php7-embed \
				php7-pdo_sqlite \
				php7-exif \
				php7-ldap \
				php7-posix \
				php7-gettext \
				php7-json \
				php7-xml \
				php7-xmlreader \
				php7-xmlrpc \
				php7-iconv \
				php7-sysvshm \
				php7-shmop \
				php7-odbc \
				php7-phar \
				php7-pdo_pgsql \
				php7-imap \
				php7-pdo_dblib \
				php7-pgsql \
				php7-pdo_odbc \
				php7-xdebug \
				php7-zip \
				php7-cgi \
				php7-ctype \
				php7-mcrypt \
				php7-wddx \
				php7-bcmath \
				php7-calendar \
				php7-dom \
				php7-sockets \
				php7-soap \
				php7-apcu \
				php7-sysvmsg \
				php7-zlib \
				php7-bz2 \
				php7-ftp \
				apache2 \
				libxml2-dev \
				apache2-utils
RUN apk add --update --no-cache imagemagick-dev \
				ffmpeg
RUN curl -sS https://getcomposer.org/installer | php7 -- --install-dir=/usr/bin --filename=composer

RUN  rm -rf /var/cache/apk/*
RUN mkdir /var/www/project/
VOLUME  /var/www/project/
WORKDIR  /var/www/project/

# AllowOverride ALL
RUN sed -i 's#AllowOverride None#AllowOverride All#' /etc/apache2/httpd.conf

# Enable Modules
RUN sed -i 's/#LoadModule\ rewrite_module/LoadModule\ rewrite_module/' /etc/apache2/httpd.conf
#RUN sed -i 's/#LoadModule\ deflate_module/LoadModule\ deflate_module/' /etc/apache2/httpd.conf
#RUN sed -i 's/#LoadModule\ expires_module/LoadModule\ expires_module/' /etc/apache2/httpd.conf

# Document Root to /var/www/project/
RUN sed -i 's#/var/www/localhost/htdocs#/var/www/project#g' /etc/apache2/httpd.conf
RUN sed -i 's/^Listen 80$/Listen 0.0.0.0:80/' /etc/apache2/httpd.conf

# Modify php.ini settings
#RUN sed -i 's/memory_limit = .*/memory_limit = 256M/' /etc/php7/php.ini
#RUN sed -i "s/^;date.timezone =$/date.timezone = \"Europe\/Stockholm\"/" /etc/php7/php.ini

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["httpd","-D","FOREGROUND"]