FROM php:8.4-fpm

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpq-dev \
    libzip-dev \
    libicu-dev \
    && docker-php-ext-install \
    pdo_pgsql \
    zip \
    intl

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sS https://get.symfony.com/cli/installer | bash \
    && mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

COPY . /var/www

WORKDIR /var/www

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN composer install --optimize-autoloader

RUN chown -R www-data:www-data /var/www/var

CMD ["php-fpm"]
