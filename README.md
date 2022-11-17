# micro-auth

Microservice for user authentication.

## Dependencies
- Ruby 3.1.0
- PostgreSQL 9.6+

## Installation
1. Create databases
```
psql >
CREATE DATABASE micro_auth_development;
CREATE DATABASE micro_auth_test;
```
2. Install app dependencies
```
bundle install
```
3. Run DB migrations
```
bundle exec rake db:migrate
```
4. Fill DB with initial data
```
bundle exec rake db:seed
```

## HTTP
### To run the app
```
bin/http
```
The app is running by default at `http://localhost:3001`.

To change the port edit file `config/settings.yml`.

## RPC
### To run the app
```
bin/rpc
```

## HTTP Endpoints
### Signup
```
POST http://localhost:3001/signup

PARAMS
{
  name: 'Ivan',
  email: 'ivan@test.com',
  password: 'q1w2e3r4'
}

RESPONSE
201 Created

OR

422 Unprocessable Entity
{
  errors: [
    {
      detail: 'email already exists',
      source: {
        pointer: '/data/attributes/email'
      }
    }
  ]
}
```

### Login
```
POST http://localhost:3001/auth

PARAMS
{
  email: 'ivan@test.com',
  password: 'q1w2e3r4'
}

RESPONSE
201 OK
{
  meta: {
    token: 'eyJhbGciOiJIUzI1NiJ9...TJLU'
  }
}

OR

401 Unauthorized
{
  errors: [
    {
      detail: 'Authentication failed: wrong email or password'
    }
  ]
}
```

### Auth
```
GET http://localhost:3001/auth

Header:

{
  "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9...TJLU",
}

RESPONSE
200 OK
{
  meta: {
    user_id: 1
  }
}

OR

403 Forbidden
{
  errors: [
    {
      detail: 'Invalid token'
    }
  ]
}
```

### To run tests
```
bundle exec rspec
```
