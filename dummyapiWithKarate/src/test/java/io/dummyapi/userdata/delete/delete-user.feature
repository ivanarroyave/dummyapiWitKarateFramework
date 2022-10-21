Feature: Delete user.
  As a manager user
  I need a way to delete any kind of user
  for perform the admin role functions.

  Background:
    * call read('../../common-definitions.feature@CommonDefinitionsForDummyapi')
    And headers headerConfiguration

  Scenario: Delete an user.
    * call read('../../common-definitions.feature@CommonDefinitionsCreateUser')
    Given url urlBase + 'user/' + userCreationResponse.id
    When method delete
    Then request 200
    And match $.id == userCreationResponse.id
    And match response == read('schemas/delete-user-schema.json')
    * print response

  Scenario: Delete an user - App-id not exists in header configuration.
    * call read('../../common-definitions.feature@CommonDefinitionsCreateUser')
    Given url urlBase + 'user/blablabla'
    And header app-id = '50fk4'
    When method delete
    Then request 403
    And match $.error == "APP_ID_NOT_EXIST"
    And match response == read('schemas/app-id-no-exist-schema.json')
    * print response

  Scenario: Delete an user - App-id missing in header configuration.
    Given url urlBase + 'user/blablabla'
    And header app-id = ''
    When method delete
    Then request 403
    And match $.error == "APP_ID_MISSING"
    And match response == read('schemas/app-id-missing-schema.json')
    * print response

  Scenario: Delete a user with an invalid identification.
    Given url urlBase + 'user/blablabla'
    When method delete
    Then request 400
    And match $.error == "PARAMS_NOT_VALID"
    And match response == read('schemas/params-not-valid-schema.json')
    * print response

  Scenario: Delete a user with an identification deleted previously.
    * call read('../../common-definitions.feature@CommonDefinitionsDeleteUser')
    Given url urlBase + 'user/' + userDeletionResponse.id
    When method delete
    Then request 404
    And match $.error == "RESOURCE_NOT_FOUND"
    And match response == read('schemas/resource-no-found-schema.json')
    * print response

  Scenario: Try to delete some user without user identification.
    Given url urlBase + 'user/'
    When method delete
    Then request 404
    And match $.error == "PATH_NOT_FOUND"
    And match response == read('schemas/path-not-found.json')
    * print response


