curl -H 'Content-Type: application/json' -d '{"email":"nv2@mail.com", "password":"123123123"}' http://localhost:3000/authenticate

curl -H 'Content-Type: application/json' -H 'Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE0OTczNDc2Mjl9.lTJa8a19aYRJHuq4v43qv-BSdxx_trl6kKq4QiuU2IU' -d '{"latitude":"106", "longitude": "20", "percentage": "30"}' localhost:3000/check_ins

curl -H 'Content-Type: application/json' -H 'Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE0OTc1MTg5OTF9.t8uuBtXZPIfqMXP_WePIuCtg8l9lACAZRNsf0Ly7rwc' -d '{"latitude":"106.2", "longitude": "20.2", "percentage": "32"}' localhost:3000/check_outs

eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE0OTc1MTg5OTF9.t8uuBtXZPIfqMXP_WePIuCtg8l9lACAZRNsf0Ly7rwc