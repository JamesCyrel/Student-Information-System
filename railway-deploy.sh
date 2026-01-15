#!/bin/bash
set -e

echo "Running database migrations..."
php artisan migrate --force

echo "Caching configuration..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "Starting application..."
exec php artisan serve --host=0.0.0.0 --port=$PORT

