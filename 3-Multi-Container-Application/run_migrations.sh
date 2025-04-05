#!/bin/bash
docker-compose up --build -d
echo "Waiting for the database to be ready..."
sleep 30  

docker-compose exec web flask db init
docker-compose exec web flask db migrate -m "Initial migration"
docker-compose exec web flask db upgrade

echo "Database migrations completed!"