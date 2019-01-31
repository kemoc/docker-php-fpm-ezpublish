# Docker > Nginx > PHP-FPM

eZPublish PHP-FPM configuration with Docker.

Repo: https://github.com/kemoc/docker-php-fpm-ezpublish/tree/master/build

## Create non DIST files

Copy and rename:

```
cp .env.dist.env .env
cp usr/local/etc/php/conf.d/zz-php.ini.dist.ini usr/local/etc/php/conf.d/zz-php.ini
```

Configure `.env`, `zz-php.ini` if needed.

## License: LICENSE file