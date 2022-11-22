#!/bin/bash

set -e

##let the container build completely.
#sleep 15

chmod -R 777 /var/www/html/DockerLaravelMailService
chown -R www-data:www-data /var/www/html/DockerLaravelMailService
mkdir -p /var/www/html/DockerLaravelMailService/bootstrap/cache
find /var/www/html/DockerLaravelMailService -type f -exec chmod 644 {} \;
find /var/www/html/DockerLaravelMailService -type d -exec chmod 755 {} \;
/etc/init.d/apache2 restart
cd /var/www/html/DockerLaravelMailService && chgrp -R www-data storage bootstrap/cache && chmod -R ug+rwx storage bootstrap/cache
cd /var/www/html/DockerLaravelMailService && php artisan cache:clear &&
php artisan config:clear && php artisan migrate:refresh && php artisan serve


echo "Account API start"
exec "$@"