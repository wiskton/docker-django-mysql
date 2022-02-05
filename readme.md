# Docker Django and Mysql

## create a new container
docker-compose up --build

## run application
docker-compose up

## execute makemigrations
docker-compose run web python project/manage.py makemigrations

## execute migrate
docker-compose run web python project/manage.py migrate