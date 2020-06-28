FROM composer:latest as builder

WORKDIR /app/

COPY composer.* ./
RUN composer install --prefer-dist --no-scripts --no-autoloader && rm -rf /root/.composer
#--no-dev

FROM php:7.3-fpm

WORKDIR /var/www

COPY --from=builder /app/vendor /var/www/vendor
COPY . /var/www
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN composer dump-autoload --no-scripts --optimize
# --no-dev
