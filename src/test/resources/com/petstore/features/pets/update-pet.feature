@regression @pets
Feature: Actualizar mascotas en PetStore

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'

  @smoke @update
  Scenario: Actualizar nombre y status de mascota existente
    Given path '/pet'
    And request
      """
      {
        "id": 1,
        "name": "DoggoActualizado",
        "status": "sold",
        "photoUrls": ["http://foto.com/img.jpg"]
      }
      """
    When method PUT
    Then status 200
    And match response.name == 'DoggoActualizado'
    And match response.status == 'sold'

  @update
  Scenario: Actualizar solo el status de una mascota
    Given path '/pet'
    And request { id: 2, name: 'Cat 2', status: 'pending', photoUrls: ['http://foto.com/img.jpg'] }
    When method PUT
    Then status 200
    And match response.status == 'pending'

  @update @negative
  Scenario: Actualizar mascota con ID inexistente
    Given path '/pet'
    And request { id: 999999999, name: 'Fantasma', status: 'available', photoUrls: ['http://foto.com/img.jpg'] }
    When method PUT
    Then status 200

  @update @data-driven
  Scenario Outline: Actualizar status a múltiples valores válidos
    Given path '/pet'
    And request { id: <id>, name: '<name>', status: '<status>', photoUrls: ['http://foto.com/img.jpg'] }
    When method PUT
    Then status 200
    And match response.status == '<status>'

    Examples:
      | id | name    | status    |
      | 1  | Doggo   | available |
      | 2  | Cattie  | pending   |
      | 3  | Birdie  | sold      |