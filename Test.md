curl -H 'Content-Type: application/json' -d '{"email":"nv1@mail.com", "password":"123123123"}' http://localhost:3000/authenticate

curl -H 'Content-Type: application/json' -H 'Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE0OTczNDc2Mjl9.lTJa8a19aYRJHuq4v43qv-BSdxx_trl6kKq4QiuU2IU' localhost:3000/history_info