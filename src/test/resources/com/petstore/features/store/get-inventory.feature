@regression @store
Feature: Consultar inventario de la tienda

  Background:
    * url baseUrl
    * header Accept = 'application/json'

  @smoke @inventory
  Scenario: Obtener inventario completo
    Given path '/store/inventory'
    When method GET
    Then status 200
    And match response == '#object'

  @inventory
  Scenario: Validar que el inventario contiene claves numéricas
    Given path '/store/inventory'
    When method GET
    Then status 200
    And def keys = Object.keys(response)
    And assert keys.length > 0

  @inventory
  Scenario: Validar que los valores del inventario son numéricos
    Given path '/store/inventory'
    When method GET
    Then status 200
    And match each response == '#number'