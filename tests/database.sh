#!/usr/bin/bash

# Testing create action
create_response=`curl -sS -X POST \
  http://$PB_HOST/api/collections/test/records \
  --header "Authorization: $TOKEN" \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data-raw '{
    "name": "Harris Schwartz",
    "age": "25",
    "married": "true"
  }' | jq -r '.name'
`

if [[ "$create_response" == "Harris Schwartz" ]]; then
    echo "Passed record create test"
else
    echo "Error: Failed to create a new record"
    exit 1
fi