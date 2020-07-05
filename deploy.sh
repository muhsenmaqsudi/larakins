cp .env.example .env
chmod -R 775 ./bootstrap/cache
chmod -R 775 ./storage
composer install --optimize-autoloader --no-dev
php artisan config:cache
php artisan route:cache
php artisan view:cache
