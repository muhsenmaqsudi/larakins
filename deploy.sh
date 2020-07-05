FILE=/home/maqsudi/workspace/larakins/.env
if [ -f $FILE ]; then
    echo "$FILE exists"
else
    cp .env.example .env
    php artisan key:generate
fi

#chmod -R 775 storage bootstrap/cache
#chown -R $USER:www-data storage bootstrap/cache
composer install --optimize-autoloader --no-dev
php artisan config:cache
php artisan route:cache
php artisan view:cache
