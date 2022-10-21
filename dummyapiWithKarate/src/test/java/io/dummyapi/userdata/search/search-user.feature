Feature: Search user.
  As a manager user
  I need a way to search any kind of user
  for perform the admin role functions.

  Background:
    * def urlResource = Java.type('io.dummyapi.ConfigService').DUMMY_API_BASE_URL.getValue() + 'user/'
    * print urlResource
    * def someData = {app-id: '63516da13945d3e8da8889d7'}
    * headers someData
    Given url urlResource

  Scenario: Search all users.
    Given url 'https://dummyapi.io/data/v1/user'
    When method get
    Then request 200
    * def userSchema =
    """
      {
        "id": "#string",
        "title": "#string",
        "firstName": "#string",
        "lastName": "#string",
        "picture": "#string"
      }
    """
    * def allUsersSchema =
    """
    {
      "data": "#[] userSchema",
      "total": "#number",
      "page": "#number",
      "limit": "#number"
    }
    """
    And match response == allUsersSchema
    And match $.limit == 20
    * print response

  Scenario: Search an user by id.
    Given url 'https://dummyapi.io/data/v1/user/60d0fe4f5311236168a109ca'
    When method get
    Then request 200
    And match response ==
    """
      {
        "id": "60d0fe4f5311236168a109ca",
        "title": "ms",
        "firstName": "Sara",
        "lastName": "Andersen",
        "picture": "https://randomuser.me/api/portraits/women/58.jpg",
        "gender": "female",
        "email": "sara.andersen@example.com",
        "dateOfBirth": "1996-04-30T19:26:49.610Z",
        "phone": "92694011",
        "location": {
          "street": "9614, SÃ¸ndermarksvej",
          "city": "Kongsvinger",
          "state": "Nordjylland",
          "country": "Denmark",
          "timezone": "-9:00"
        },
        "registerDate": "2021-06-21T21:02:07.374Z",
        "updatedDate": "2021-06-21T21:02:07.374Z"
      }
    """
    * print response
