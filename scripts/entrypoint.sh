#!/bin/sh

set -e

python manage.py collectstatic --noinput

uwsgi --socket :8080 --master --enable-threads --module personal_portfolio.wsgi

