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

### Example

### Request
```
{
    "member": {
        "email": "bookie555@ku.th",
        "password": "12345678",
        "password_confirmation": "12345678",
        "first_name": "asd",
        "gender" : "Male",
        "last_name": "dsa",
        "birth_date": "18/10/1994",
        "phone_number": "0817731713",
        "identification_number": "asds"
    },
}
```

### Response `status 201 Created`
```
{
  "id": 4,
  "email": "bookie555@ku.th",
  "first_name": "asd",
  "last_name": "dsa",
  "phone_number": "0817731713",
  "identification_number": "asds",
  "gender": "Male",
  "birth_date": null,
  "created_at": "2015-10-20T13:37:03.359Z",
  "updated_at": "2015-10-20T13:37:03.359Z",
  "auth_token": "k8BLDgTgS3aAsb4L4aqc",
  "addresses": [
    {
      "id": 3,
      "first_name": "dsa",
      "last_name": "dsa",
      "latitude": "12",
      "longitude": "12",
      "information": "Hello",
      "member_id": 4,
      "created_at": "2015-10-20T13:37:03.374Z",
      "updated_at": "2015-10-20T13:37:03.374Z"
    }
  ]
}
```
***
Login
====================

# API

    POST https://bookieservice.herokuapp.com/api/sessions

### Parameters for session **Required.**

| Field Name | Type | Description |
|:------------ |:---------------:| -------------:|
| email | String | **Required** Email of the Member |
| password | String (Length: 8-72) | **Required** Password of the Member |

### Exmaple

### Request
```
{
    "session" : {
        "email" : "bookie555@ku.th",
        "password" : "12345678"
    }
}
```

### Response `status 200 OK`
```
{
  "id": 4,
  "email": "bookie555@ku.th",
  "first_name": "asd",
  "last_name": "dsa",
  "phone_number": "0817731713",
  "identification_number": "asds",
  "gender": "Male",
  "birth_date": null,
  "created_at": "2015-10-20T13:37:03.359Z",
  "updated_at": "2015-10-20T13:43:54.395Z",
  "auth_token": "dNaXJJgvvtnzHjQvbBa5"
}
```

### Response `status 422 Unprocessable Entity`
```
{
  "errors": "Invalid email or password"
}
```

### Response `status 500 Internal Server Error` ( email not found, etc.)
```
{
  "status": "500",
  "error": "Internal Server Error"
}
```
***
Edit profile
====================

# API

    PUT https://bookieservice.herokuapp.com/api/members

### Parameters for member **Required.** (Header must contain 'Authorization' with member's token)

| Field Name | Type | Description |
|:------------ |:---------------:| -------------:|
| password | String (Length: 8-72) | **Required** Password of the Member |
| password_confirmation | String (Length: 8-72) | **Required** Confirmation of the password |
| email | String | **Optional** Email of the Member |
| first_name | String | **Optional** Firstname of the Member |
| last_name | String | **Optional** Lastname of the Member |
| phone_number | String | **Optional** Phone number of the Member |
| identification_number | String (Length: 13) | **Optional** Citizen ID of the Member |
| gender | String (Male,Female) | **Optional** Gender of the Member |
| birth_date | Date (DD/MM/YYYY) | **Optional** Birth date of the Member |

### Exmaple

### Request
```
{
    "member": {
        "password": "12345678",
        "password_confirmation": "12345678",
        "gender" : "Female"
    }
}
```

### Response `status 200 OK`
```
{
  "id": 4,
  "email": "bookie555@ku.th",
  "first_name": "asd",
  "last_name": "dsa",
  "phone_number": "0817731713",
  "identification_number": "asds",
  "gender": "Male",
  "birth_date": null,
  "created_at": "2015-10-20T13:37:03.359Z",
  "updated_at": "2015-10-20T13:43:54.395Z",
  "auth_token": "dNaXJJgvvtnzHjQvbBa5"
}
```

### Response `status 422 Unprocessable Entity` (In case of wrong password)
```
{
  "errors": "Wrong password"
}
```

### Response `status 401 Unauthorized` ( Invalid token )
```
{
  "errors": "Not authenticated"
}
```
