# Docker Django and Mysql

## alter file heroku_deploy.sh
APP_NAME=willemallan

## create a new container
docker-compose up --build

## run application
docker-compose up

## create new admin user
docker-compose run web python project/manage.py createsuperuser

## execute makemigrations
docker-compose run web python project/manage.py makemigrations

## execute migrate
docker-compose run web python project/manage.py migrate