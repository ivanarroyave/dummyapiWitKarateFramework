Feature: Create user.
  As a manager user
  I need a way to create any kind of user
  for perform the admin role functions and so, the user would star they work process too.

  Background:
    * call read('../../common-definitions.feature@CommonDefinitionsForDummyapi')
    * headers headerConfiguration

  Scenario: Create a normal user.
    * def user = Java.type('io.dummyapi.userdata.User').userBody()
    * def userBody = Java.type('io.dummyapi.userdata.User').generateBodyForCreateUser(user)
    Given url urlBase + 'user/create'
    And request userBody
    When method post
    Then request 200
    And match user.title == $.title
    And match user.firstName == $.firstName
    And match user.lastName == $.lastName
    And match user.gender == $.gender
    And match user.email == $.email
    And match user.phone == $.phone
    And match response == read('schemas/create-user-schema.json')
    * print response

  Scenario: Try to create a user without data.
    * def emptyUser = Java.type('io.dummyapi.userdata.User').emptyUserBody()
    * def userBody = Java.type('io.dummyapi.userdata.User').generateBodyForCreateUser(emptyUser)
    Given url urlBase + 'user/create'
    And request userBody
    When method post
    Then request 400
    And match response == read('schemas/body-not-valid-schema.json')
    * print response
