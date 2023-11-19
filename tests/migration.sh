# Testing migration
response=`curl -sS -X GET \
    http://$PB_HOST/api/collections/test \
    --header "Authorization: $TOKEN" \
    -o /dev/null \
    -w "%{http_code}"
`

if [[ "$response" == "200" ]]; then
    echo "Passed migration test"
else
    echo "Error: Failed to validate migrated collection"
    exit 1
fi