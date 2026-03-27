@regression @store
Feature: Gestión de órdenes en la tienda

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'

  @smoke @orders
  Scenario: Crear una orden exitosamente
    Given path '/store/order'
    And request
      """
      {
        "id": 3001,
        "petId": 1,
        "quantity": 1,
        "shipDate": "2025-01-01T00:00:00.000Z",
        "status": "placed",
        "complete": false
      }
      """
    When method POST
    Then status 200
    And match response.status == 'placed'
    And match response.petId == 1
    And match response.id == 3001

  @orders
  Scenario: Crear orden y validar schema completo
    Given path '/store/order'
    And request
      """
      {
        "id": 3002,
        "petId": 2,
        "quantity": 1,
        "shipDate": "2025-06-01T00:00:00.000Z",
        "status": "placed",
        "complete": false
      }
      """
    When method POST
    Then status 200
    And match response ==
      """
      {
        "id": "#number",
        "petId": "#number",
        "quantity": "#number",
        "shipDate": "#string",
        "status": "#string",
        "complete": "#boolean"
      }
      """

  @orders @read
  Scenario: Obtener orden por ID
    Given path '/store/order'
    And request
      """
      {
        "id": 3003,
        "petId": 3,
        "quantity": 2,
        "shipDate": "2025-06-01T00:00:00.000Z",
        "status": "placed",
        "complete": false
      }
      """
    When method POST
    Then status 200

    Given path '/store/order/3003'
    When method GET
    Then status 200
    And match response.id == 3003
    And match response.petId == 3

  @orders @negative
  Scenario: Obtener orden con ID inexistente
    Given path '/store/order/999999'
    When method GET
    Then status 404

  @orders @negative
  Scenario: Crear orden con quantity negativa
    Given path '/store/order'
    And request
      """
      {
        "id": 3099,
        "petId": 1,
        "quantity": -1,
        "shipDate": "2025-06-01T00:00:00.000Z",
        "status": "placed",
        "complete": false
      }
      """
    When method POST
    Then status 200

  @orders @delete
  Scenario: Crear y eliminar una orden
    Given path '/store/order'
    And req