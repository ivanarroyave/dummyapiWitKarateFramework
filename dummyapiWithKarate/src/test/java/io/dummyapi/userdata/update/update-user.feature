Feature: Update user.
  As a manager user
  I need a way to update any kind of user information
  for perform the admin role functions and so, the user would continue they work process too.

  Background:
    * call read('../../common-definitions.feature@CommonDefinitionsForDummyapi')
    * headers headerConfiguration

  Scenario: Update a normal user using all fields.
    * call read('../../common-definitions.feature@CommonDefinitionsCreateUser')
    * def user = Java.type('io.dummyapi.userdata.User').userBody()
    * json bodyRequest = Java.type('io.dummyapi.userdata.User').generateBodyForCreateUser(user)
    Given url urlBase + 'user/' + userCreationResponse.id
    And request bodyRequest
    When method put
    Then status 200
    And match $.id == userCreationResponse.id
    And match $.title == bodyRequest.title
    And match $.firstName == bodyRequest.firstName
    And match $.lastName == bodyRequest.lastName
    And match $.gender == bodyRequest.gender
    And match $.email == userCreationResponse.email
    And match $.phone == bodyRequest.phone
    And match $.registerDate == userCreationResponse.registerDate
    And match $.updatedDate != userCreationResponse.updatedDate

    And match response == read('schemas/update-user-schema.json')

    * print response
