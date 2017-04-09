FROM php:7-fpm
# install the PHP extensions we need
RUN set -ex \
  && buildDeps=' \
    libjpeg62-turbo-dev \
    libpng12-dev \
    libpq-dev \
  ' \
  && apt-get update && apt-get install -y --no-install-recommends $buildDeps && rm -rf /var/lib/apt/lists/* \
  && docker-php-ext-configure gd \
    --with-jpeg-dir=/usr \
    --with-png-dir=/usr \
  && docker-php-ext-install -j "$(nproc)" gd mbstring pdo pdo_mysql pdo_pgsql zip \
  && apt-mark manual \
    libjpeg62-turbo \
    libpq5 \
  && apt-get purge -y --auto-remove $buildDeps
EXPOSE 9000
CMD ["php-fpm"]