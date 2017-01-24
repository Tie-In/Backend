Register
====================

	POST http://tieinservice.herokuapp.com/api/users

### Parameters for user **Required.**

| Field Name | Type | Description |
|:------------ |:---------------:| -------------:|
| email | String | **Required** |
| password | String (Length: 8-72) | **Required**|
| password_confirmation | String (Length: 8-72) | **Required** Confirmation of the password |
| first_name | String | **Required** |
| username | String | **Required** |
| birth_date | Date (DD/MM/YYYY) | **Required** |
| phone_number | String | **Required** |

### Request
```
{
  "user": {
  	"email": "test@test.com",
	"username": "test",
	"firstname": "Tan",
	"lastname": "Pornsriniyom",
	"password": 12341234,
	"password_confirmation": 12341234,
	"birth_date": "11/11/2011",
	"phone_number": "023131323"
  }
}
```

### Response `status 200 OK`
```
{
  "id": 2,
  "email": "test@test.com",
  "username": "test",
  "created_at": "2017-01-24T15:13:00.678Z",
  "updated_at": "2017-01-24T15:13:00.678Z",
  "auth_token": "ZCr6hJbznu1_pJYEghuG",
  "firstname": "Tan",
  "lastname": "Pornsriniyom",
  "birth_date": "2011-11-11",
  "phone_number": "023131323"
}
```

### Response `status 422 unprocessable entity`
```
{
  "errors": {
    "email": [
      "has already been taken"
    ]
  }
}
```

```
{
  "errors": {
    "password": [
      "can't be blank"
    ],
    "password_confirmation": [
      "doesn't match Password"
    ]
  }
}
```

***
Login
====================

# API

    POST /api/sessions

### Parameters for session **Required.**

| Field Name | Type | Description |
|:------------ |:---------------:| -------------:|
| email/username | String | **Required** |
| password | String (Length: 8-72) | **Required** |

### Request
```
{
  "session": {
    "email": "test@test.com",
    "password": "12341234"
	}
}
```

### Response `status 200 OK`
```
{
  "id": 2,
  "email": "test@test.com",
  "username": "test",
  "created_at": "2017-01-24T15:13:00.678Z",
  "updated_at": "2017-01-24T15:22:19.736Z",
  "auth_token": "--2kkmBavfEwJdvNFyrs",
  "firstname": "Tan",
  "lastname": "Pornsriniyom",
  "birth_date": "2011-11-11",
  "phone_number": "023131323"
}
```

### Response `status 422 Unprocessable Entity`
```
{
  "errors": "Invalid email/username or password"
}
```
