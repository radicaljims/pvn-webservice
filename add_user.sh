curl --verbose --request POST --header "Content-Type: application/json" \
     --data '{"name": "foo", "email": "foo@foo.com", "registrationDate": "2015-11-11"}' \
         http://localhost:8081/users
echo
