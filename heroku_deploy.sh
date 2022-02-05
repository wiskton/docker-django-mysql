#!/bin/sh -e
APP_NAME=willemallan

git remote add heroku git@heroku.com:$APP_NAME.git
git fetch heroku
MIGRATION_CHANGES=$(git diff HEAD heroku/master --name-only -- */migrations/* | wc -l)
echo "$MIGRATION_CHANGES db changes."

# migrations require downtime so enter maintenance mode
if test $MIGRATION_CHANGES -gt 0; then
  heroku maintenance:on --app $APP_NAME
fi

# deploy code changes (and implicitly restart the app and any running workers)
git push heroku $CIRCLE_SHA1:refs/heads/master

# run database migrations if needed and restart background workers once finished
if test $MIGRATION_CHANGES -gt 0; then
  heroku run python manage.py migrate --app $APP_NAME
  heroku restart --app $APP_NAME
fi

heroku maintenance:off --app $APP_NAME