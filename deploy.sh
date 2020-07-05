cp .env.example .env
chmod -R 775 storage bootstrap/cache
chown -R $USER:www-data storage bootstrap/cache
composer install --optimize-autoloader --no-dev
php artisan key:generate
php artisan config:cache
php artisan route:cache
php artisan view:cache
