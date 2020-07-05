
FILE=/home/maqsudi/workspace/larakins/.env
if [ -f $FILE ]; then
    echo "$FILE exists"
else
    echo "$FILE does not exists"
fi
#chmod -R 775 storage bootstrap/cache
#chown -R $USER:www-data storage bootstrap/cache
#cp .env.example .env
composer install --optimize-autoloader --no-dev
#php artisan key:generate
php artisan config:cache
php artisan route:cache
php artisan view:cache
