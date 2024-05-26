@Sample
Feature: Sample

  Background:
    And header Content-Type = application/json
    And header Accept = */*


  @RickAndMorty
  Scenario Outline: Get character
    Given base url $(env.base_url_rickAndMorty)
    And endpoint character/<id_character>
    When execute method GET
    Then the status code should be 200
    And response should be $.name = <name>
    And response should be $.status = <status>
    And validate schema jsons/schemas/character.json

    Examples:
      | id_character | name         | status |
      | 1            | Rick Sanchez | Alive  |
      | 2            | Morty Smith  | Alive  |

  @petstore
  Scenario Outline: Add a new pet to the store
    Given base url $(env.base_url_petstore)
    And endpoint pet
    And header accept = application/json
    And header Content-Type = application/json
    And body jsons/bodies/body.json
    When execute method POST
    Then the status code should be 200
    And response should be name = <name>
    And validate schema jsons/schemas/pet.json

    Examples:
      | name   |
      | doggie |

  @petstore
  Scenario Outline: Add a new pet to the store
    Given base url $(env.base_url_petstore)
    And endpoint pet
    And header accept = application/json
    And header Content-Type = application/json
    And delete keyValue tags[0].id in body jsons/bodies/body2.json
    And set value 15 of key tags[1].id in body jsons/bodies/body2.json
    And set value "tag2" of key tags[1].name in body jsons/bodies/body2.json
    When execute method POST
    Then the status code should be 200
    And response should be name = <name>
    And validate schema jsons/schemas/pet.json

    Examples:
      | name   |
      | doggie |

@practicaClase
  ##NO ME ESTA FUNCIONANDO
Scenario Outline: Agregar workspace
  Given base url https://api.clockify.me/api
  And endpoint /v1/workspaces
  And header Content-Type = application/json
  And header x-api-key = NjBhNjU4MGUtMDI0Zi00M2EwLWEyNTgtYmE4NTcwMWY1YWQ5
  And set values <nombreWorkspace> of keys name in body jsons/bodies/PracticaClase.json
  When execute method POST
  Then the status code should be 201
  And response should be name = Lippia

  Examples:
  | nombreWorkspace |
  | Lippia          |

@practicaClase2
Scenario: Obtener Workspace
  Given base url https://api.clockify.me/api
  And endpoint /v1/workspaces
  And header x-api-key = NjBhNjU4MGUtMDI0Zi00M2EwLWEyNTgtYmE4NTcwMWY1YWQ5
  When execute method GET
  Then the status code should be 200
  And response should be [1].name = Agregar Workspace Prueba
  * define espacioDeTrabajo = response[1].id

@practicaClase3
Scenario: Obtener clientes de un Workspace
  Given base url https://api.clockify.me/api
  And endpoint /v1/workspaces
  And header x-api-key = NjBhNjU4MGUtMDI0Zi00M2EwLWEyNTgtYmE4NTcwMWY1YWQ5
  And execute method GET
  And the status code should be 200
  And response should be [1].name = Agregar Workspace Prueba
  * define espacioDeTrabajo = response[1].id
  And base url https://api.clockify.me/api
  And endpoint /v1/workspaces/{{espacioDeTrabajo}}/clients
  And header x-api-key = NjBhNjU4MGUtMDI0Zi00M2EwLWEyNTgtYmE4NTcwMWY1YWQ5
  When execute method GET
  Then the status code should be 200

  @practicaClase4
  Scenario: Obtener clientes de un Workspace con CALL
    Given call Sample.feature@practicaClase2
    And base url $(env.base_url)
    And endpoint /v1/workspaces/{{espacioDeTrabajo}}/clients
    And header x-api-key = $(env.x_api_key)
    ##CONSULTAR POR QUÉ NO FUNCIONA LA API KEY
    When execute method GET
    Then the status code should be 200

  @practicaClase5
  Scenario: Eliminar Cliente
    Given base url $(env.base_url)
    And endpoint /v1/workspaces/664c098f7d59624baae8205e/clients/665375f115b9d0645951c48c
    And header x-api-key = $(env.x_api_key)
    When execute method DELETE
    Then the status code should be 200
  
