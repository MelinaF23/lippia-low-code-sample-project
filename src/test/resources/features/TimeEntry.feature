Feature: Manejo de horas de un proyecto

  Background:
    Given base url https://api.clockify.me/api
    And header x-api-key = $(env.x_api_key)
    And header Content-Type = application/json

  @getaSpecificTimeEntryOnWorkspace
  Scenario: Consultar horas registradas exitosamente
    * define wsID = 664c098f7d59624baae8205e
    * define teID = 66674ecd1dd7f20133c3506e
    And endpoint /v1/workspaces/{{wsID}}/time-entries/{{teID}}
    When execute method GET
    Then the status code should be 200

  @addaNewTimeEntry
  Scenario Outline: Agregar horas a un proyecto exitosamente
    * define wsID = 664c098f7d59624baae8205e
    And endpoint /v1/workspaces/{{wsID}}/time-entries
    And set value <name> of key name in body jsons/bodies/addaNewTimeEntry.json
    And set value <namespace> of key namespace in body jsons/bodies/addaNewTimeEntry.json
    And set value <value> of key value in body jsons/bodies/addaNewTimeEntry.json
    And set value <description> of key description in body jsons/bodies/addaNewTimeEntry.json
    And set value <end> of key end in body jsons/bodies/addaNewTimeEntry.json
    And set value <projectId> of key projectId in body jsons/bodies/addaNewTimeEntry.json
    And set value <start> of key start in body jsons/bodies/addaNewTimeEntry.json
    When execute method POST
    Then the status code should be 201
    * define id = response.id

    Examples:
      | name | namespace | value      | description     | end                  | projectId                | start                |  |  |
      | QA   | user_info | Estudiante | TPAcademy2024.4 | 2024-06-10T09:00:00Z | 664c0e50f0024241f5c9968c | 2024-06-10T06:00:00Z |  |  |

  @updateTimeEntryOnWorkspace
  Scenario Outline: Editar campo description de un registro exitosamente
    Given call TimeEntry.feature@getaSpecificTimeEntryOnWorkspace
    And endpoint /v1/workspaces/{{wsID}}/time-entries/{{teID}}
    And set value <description> of key description in body jsons/bodies/updateTimeEntry.json
    And set value <end> of key end in body jsons/bodies/updateTimeEntry.json
    And set value <start> of key start in body jsons/bodies/updateTimeEntry.json
    And set value <projectId> of key projectId in body jsons/bodies/updateTimeEntry.json
    When execute method PUT
    Then the status code should be 200
    And response should be description = <description>

    Examples:
      | description | end                  | start                | projectId                |
      | LowCode2024 | 2024-06-03T13:30:00Z | 2024-06-03T10:30:00Z | 664c0e50f0024241f5c9968c |

  @deleteTimeEntryFromWorkspace
  Scenario: Eliminar hora registrada exitosamente
    Given call TimeEntry.feature@addaNewTimeEntry
    And endpoint /v1/workspaces/{{wsID}}/time-entries/{{id}}
    When execute method DELETE
    Then the status code should be 204