@regression @pets
Feature: Eliminar mascotas en PetStore

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * header api_key = '#(apiKey)'

  @smoke @delete
  Scenario: Crear y luego eliminar una mascota — flujo completo
    # Primero creamos la mascota
    Given url baseUrl + '/pet'
    And header Content-Type = 'application/json'
    And request { id: 9001, name: 'TempPet', status: 'available', photoUrls: ['http://foto.com/img.jpg'] }
    When method POST
    Then status 200

    # Ahora la eliminamos
    Given url baseUrl + '/pet/9001'
    And header api_key = '#(apiKey)'
    When method DELETE
    Then status 200

  @delete @negative
  Scenario: Eliminar mascota con ID inexistente — debe retornar 404
    Given path '/pet/999999888'
    When method DELETE
    Then status 404

  @delete @negative
  Scenario: Eliminar mascota con ID inválido (texto)
    Given path '/pet/noesunid'
    When method DELETE
    Then status 404