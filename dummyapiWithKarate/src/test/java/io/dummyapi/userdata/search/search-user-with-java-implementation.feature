Feature: Search user.
  As a manager user
  I need a way to search any kind of user
  for perform the admin role functions.

  Background:
    * call read('../../common-definitions.feature@CommonDefinitionsForDummyapi')
    * headers headerConfiguration

  Scenario: Search all users.
    Given url urlBase + 'user/'
    When method get
    Then request 200
    And match response == read('schemas/search-users-schema.json')
    And match $.limit == 20
    * print response

  Scenario: Search an user by id.
    * call read('../../common-definitions.feature@CommonDefinitionsCreateUser')
    Given url urlBase + 'user/' + userCreationResponse.id
    When method get
    Then request 200
    And match response == read('schemas/search-user-schema.json')
    * print response