#!/bin/bash
set -e

echo "Setting cache to file driver temporarily to avoid DB connection during cache clear..."
export CACHE_STORE=file

echo "Clearing previous caches..."
php artisan config:clear || true
php artisan route:clear || true
php artisan view:clear || true
php artisan cache:clear || true

echo "Waiting for database connection..."
sleep 3

echo "Running database migrations..."
php artisan migrate --force

echo "Caching configuration..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "Starting application..."
exec php artisan serve --host=0.0.0.0 --port=$PORT

