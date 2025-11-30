FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    gettext \
    && rm -rf /var/lib/apt/lists/*


COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app

# Ensure entrypoint script is executable (correct path)
RUN chmod +x /app/entrypoint.sh || true

EXPOSE 8000

# Entrypoint will handle migrations, collectstatic, then run gunicorn
ENTRYPOINT ["/app/entrypoint.sh"]
