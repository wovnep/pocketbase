#!/usr/bin/bash
export PB_HOST=0.0.0.0:8989
export PB_IDENTITY=test@example.com
export PB_PASSWORD=test123456

# Running docker image
docker run --name pocketbase -d -v ./pb_migrations:/usr/src/app/pb_migrations -p 8989:8989 wovnep/pocketbase:test serve --http $PB_HOST
sleep 2

# Creating admin account
docker exec -it pocketbase ./pocketbase admin create $PB_IDENTITY $PB_PASSWORD
sleep 2

response=`curl -sS -X POST \
  http://$PB_HOST/api/admins/auth-with-password \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data-raw "{
    \"identity\": \"$PB_IDENTITY\",
    \"password\": \"$PB_PASSWORD\"
}"`

export TOKEN=`echo $response | jq -r '.token'`

tests/migration.sh
tests/database.sh

# Stopping and removing docker container
docker stop pocketbase
docker rm pocketbase