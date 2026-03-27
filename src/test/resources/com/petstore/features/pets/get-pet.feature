@regression @pets
Feature: Consultar mascotas en PetStore

  Background:
    * url baseUrl
    * header Accept = 'application/json'

  @smoke @read
  Scenario: Obtener mascota por ID existente
    Given path '/pet/1'
    When method GET
    Then status 200
    And match response.id == 1
    And match response contains { id: '#number', name: '#string', status: '#string' }

  @read
  Scenario: Validar schema completo de respuesta de mascota
    Given path '/pet/1'
    When method GET
    Then status 200
    And match response ==
      """
      {
        id: '#number',
        name: '#string',
        status: '#string',
        photoUrls: '#array',
        category: '##object',
        tags: '##array'
      }
      """

  @read @negative
  Scenario: Obtener mascota con ID inexistente — debe retornar 404
    Given path '/pet/999999999'
    When method GET
    Then status 404
    And match response.message == 'Pet not found'

  @read @negative
  Scenario: Obtener mascota con ID tipo texto — debe retornar 404 o 400
    Given path '/pet/abc'
    When method GET
    Then status 404

  @read
  Scenario: Buscar mascotas por status available
    Given path '/pet/findByStatus'
    And param status = 'available'
    When method GET
    Then status 200
    And match each response[*].status == 'available'
    And match response == '#array'

  @read
  Scenario: Buscar mascotas por status pending
    Given path '/pet/findByStatus'
    And param status = 'pending'
    When method GET
    Then status 200
    And match each response[*].status == 'pending'

  @read
  Scenario: Buscar mascotas por status sold
    Given path '/pet/findByStatus'
    And param status = 'sold'
    When method GET
    Then status 200
    And match each response[*].status == 'sold'

  @read @negative
  Scenario: Buscar mascotas con status inválido
    Given path '/pet/findByStatus'
    And param status = 'invalidStatus'
    When method GET
    Then status 200
    And match response == '[]'

  @read
  Scenario: Verificar que la lista de mascotas available no está vacía
    Given path '/pet/findByStatus'
    And param status = 'available'
    When method GET
    Then status 200
    And assert response.length > 0

  @read @data-driven
  Scenario Outline: Buscar mascotas por cada status válido
    Given path '/pet/findByStatus'
    And param status = '<status>'
    When method GET
    Then status 200
    And match response == '#array'

    Examples:
      | status    |
      | available |
      | pending   |
      | sold      |