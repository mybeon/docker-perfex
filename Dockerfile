FROM php:7.4-apache

RUN apt-get update -y && \
    apt-get install -y libzip-dev zip libpng-dev libc-client-dev libkrb5-dev curl --no-install-recommends

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install -j$(nproc) imap

RUN docker-php-ext-install mysqli gd zip

RUN a2enmod rewrite

COPY ./app/ /var/www/html/

RUN chown -R www-data:www-data /var/www/html/

RUN chmod 755 /var/www/html/uploads/
RUN chmod 755 /var/www/html/application/config/
RUN chmod 755 /var/www/html/application/config/config.php
RUN chmod 755 /var/www/html/application/config/app-config-sample.php
RUN chmod 755 /var/www/html/temp/

COPY ./config.sh /var/www/html/

RUN chmod +x /var/www/html/config.sh

ENTRYPOINT [ "/var/www/html/config.sh" ]

EXPOSE 80