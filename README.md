# CSA - Forum - mwg2

# Running locally
```
$ docker-compose build
$ docker-compose up

From a different terminal:

$ docker-compose run web rake:create
$ docker-compose run web rake:migrate
$ docker-compose run web rake:seed

Go to http://localhost:3000
```

# REST API interface
The REST API is using the Basic Auth and $USERNAME and $PASSWORD have to be exchanged for actual credentials in the examples below.

## Listing all threads
**GET** `/api/topics`

1. Listing the 8 most recent threads in the forum.

```curl
curl http://localhost:3000/api/topics -u $USERNAME:$PASSWORD
```

1. Listing all threads in the forum.

```curl
curl http://localhost:3000/api/topics?all=true -u $USERNAME:$PASSWORD
```

## Get details about a specific thread
**GET** `/api/topics/:id`

1. Get a single thread by its ID

```curl
curl http://localhost:3000/api/topics/40 -u $USERNAME:$PASSWORD
```

## Creating new threads
**POST** `/api/topics`

Examples:

1. Creating a new thread containing a single post titled "I need help" with body "What is Java?".

```curl
curl -d '{"post":{"title":"I need help", "body":"What is Java?"}}' -X POST -H "Content-Type: application/json" http://localhost:3000/api/topics -u $USERNAME:$PASSWORD
```

2. Creating the same post as an anonymous user.

```curl
curl -d '{"post":{"title":"I need help", "body":"What is Java?"}, "anonymous":"true"}' -X POST -H "Content-Type: application/json" http://localhost:3000/api/topics -u $USERNAME:$PASSWORD
```
