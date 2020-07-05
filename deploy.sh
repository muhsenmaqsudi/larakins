cp .env.example .env
chmod -R 775 ./bootstrap/cache
chmod -R 775 ./storage
chown -R $USER:www-data ./storage
chown -R $USER:www-data ./bootstrap/cache
composer install --optimize-autoloader --no-dev
php artisan key:generate
php artisan config:cache
php artisan route:cache
php artisan view:cache
