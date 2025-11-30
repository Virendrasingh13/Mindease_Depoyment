#!/bin/bash
set -e

echo "Waiting for database..."
sleep 3

echo "Applying database migrations..."
python manage.py migrate --noinput

echo "Collecting static files..."
python manage.py collectstatic --noinput


echo "Starting Gunicorn..."
gunicorn Mind_Ease.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 3
