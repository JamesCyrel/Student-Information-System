#!/bin/bash
set -e

echo "Clearing previous caches..."
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan cache:clear

echo "Running database migrations..."
php artisan migrate --force

echo "Caching configuration..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "Starting application..."
exec php artisan serve --host=0.0.0.0 --port=$PORT

