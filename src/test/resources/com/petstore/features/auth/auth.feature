@auth
Feature: Validar autenticación con API Key

  Background:
    * url baseUrl

  @smoke
  Scenario: Acceder al inventario con API key válida
    Given path '/store/inventory'
    And header api_key = apiKey
    When method GET
    Then status 200

  @negative
  Scenario: Acceder sin API key — algunos endpoints igual responden
    Given path '/store/inventory'
    When method GET
    Then status 200
    And match response == '#object'