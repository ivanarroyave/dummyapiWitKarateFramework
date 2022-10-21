@ignore
Feature: Common definitions.

  Background:
    * def urlBase = Java.type('io.dummyapi.ConfigService').DUMMY_API_BASE_URL.getValue()
    * def headerConfiguration = {app-id: '63516da13945d3e8da8889d7', Content-Type: 'application/json; charset=utf-8'}

  @CommonDefinitionsForDummyapi
  Scenario: Common definitions for dummyapi

  @CommonDefinitionsCreateUser
  Scenario: create user
    * def user = Java.type('io.dummyapi.userdata.User').userBody()
    * def userBody = Java.type('io.dummyapi.userdata.User').generateBodyForCreateUser(user)
    Given url urlBase + 'user/create'
    And headers headerConfiguration
    And request userBody
    When method post
    Then status 200
    * def userCreationResponse = response
    * print response

  @CommonDefinitionsDeleteUser
  Scenario: create user
    #Create proess.
    * call read('../../common-definitions.feature@CommonDefinitionsCreateUser')

    #Delete process.
    Given url urlBase + 'user/' + userCreationResponse.id
    When method delete
    Then request 200
    * def userDeletionResponse = response
    * print response
