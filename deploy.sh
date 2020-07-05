cp .env.example .env
#sudo chmod -R 775 ./bootstrap/cache
#sudo chmod -R 775 ./storage
#sudo chown -R $USER:www-data ./storage
#sudo chown -R $USER:www-data ./bootstrap/cache
composer install --optimize-autoloader --no-dev
php artisan key:generateg
php artisan config:cache
php artisan route:cache
php artisan view:cache
