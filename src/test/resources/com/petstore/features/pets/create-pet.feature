@regression @pets
Feature: Crear mascotas en PetStore

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'

  @smoke @create
  Scenario: Crear una mascota básica exitosamente
    Given path '/pet'
    And request { id: 5001, name: 'Rex', status: 'available', photoUrls: ['http://foto.com/rex.jpg'] }
    When method POST
    Then status 200
    And match response.name == 'Rex'
    And match response.status == 'available'
    And match response.id == 5001

  @create
  Scenario: Crear mascota con categoría y tags
    Given path '/pet'
    And request
      """
      {
        "id": 5002,
        "name": "Luna",
        "status": "available",
        "category": { "id": 1, "name": "Dogs" },
        "tags": [{ "id": 1, "name": "vaccinated" }],
        "photoUrls": ["http://foto.com/luna.jpg"]
      }
      """
    When method POST
    Then status 200
    And match response.category.name == 'Dogs'
    And match response.tags[0].name == 'vaccinated'

  @create
  Scenario: Crear mascota con status pending
    Given path '/pet'
    And request { id: 5003, name: 'Buddy', status: 'pending', photoUrls: ['http://foto.com/buddy.jpg'] }
    When method POST
    Then status 200
    And match response.status == 'pending'

  @create @negative
  Scenario: Intentar crear mascota sin body — debe rechazarse
    Given path '/pet'
    And request {}
    When method POST
    Then status 405

  @create @data-driven
  Scenario Outline: Crear mascotas con distintos estados
    Given path '/pet'
    And request { id: <id>, name: '<name>', status: '<status>', photoUrls: ['http://foto.com/img.jpg'] }
    When method POST
    Then status 200
    And match response.status == '<status>'

    Examples:
      | id   | name    | status    |
      | 5010 | Perro1  | available |
      | 5011 | Gato1   | pending   |
      | 5012 | Pajaro1 | sold      |

  @create @data-driven
  Scenario Outline: Crear mascotas desde archivo JSON externo
    Given path '/pet'
    And request { id: <id>, name: '<name>', status: '<status>', photoUrls: ['http://foto.com/img.jpg'], category: { id: 1, name: '<category>' } }
    When method POST
    Then status 200
    And match response.name == '<name>'

    Examples:
      | id   | name     | status    | category |
      | 5020 | Max      | available | Dogs     |
      | 5021 | Whiskers | available | Cats     |
      | 5022 | Polly    | pending   | Birds    |