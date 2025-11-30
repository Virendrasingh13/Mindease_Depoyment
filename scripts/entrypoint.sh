#!/bin/sh
set -e

# Optional: print Python/Django versions for quick diagnostics
python -V

# Apply migrations
python manage.py migrate --noinput

# Start Django dev server on 0.0.0.0:8000 (SQLite-friendly, auto-reload when code is mounted)
python manage.py runserver 0.0.0.0:8000
#!/bin/sh
set -e

python -V

# Collect static files to STATIC_ROOT
python manage.py collectstatic --noinput

# Run migrations
python manage.py migrate --noinput

# Start gunicorn WSGI server
exec gunicorn Mind_Ease.wsgi:application \
  --bind 0.0.0.0:8000 \
  --workers 3 \
  --access-logfile - \
  --error-logfile -
