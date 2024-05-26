Feature: Project

  Background:
    Given base url https://api.clockify.me/api
    And header x-api-key = $(env.x_api_key)


  @addaNewProject
  Scenario: Crear un proyecto dentro del workspace exitosamente
    And endpoint /v1/workspaces/664c098f7d59624baae8205e/projects
    And header Content-Type = application/json
    And set value "Eliminar 4" of key name in body jsons/bodies/AddProject.json
    When execute method POST
    Then the status code should be 201

  @findProjectById
  Scenario: Consultar un proyecto por su ID exitosamente
    And endpoint /v1/workspaces/664c098f7d59624baae8205e/projects/664c0e50f0024241f5c9968c
    When execute method GET
    Then the status code should be 200
    And response should be name = Crowdar
    * define projectId = response.id
    * define workspaceId = response.workspaceId

  @updateisPublic
  Scenario: Editar el valor del campo isPublic exitosamente
    Given call Clockify.feature@findProjectById
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    And header Content-Type = application/json
    And set value false of key isPublic in body jsons/bodies/updateisPublic.json
    When execute method PUT
    Then the status code should be 200
    And response should be public = false

  @findProjectById
  Scenario: Consultar un proyecto por su ID exitosamente
    And endpoint /v1/workspaces/664c098f7d59624baae8205e/projects/664c0e50f0024241f5c9968c
    When execute method GET
    Then the status code should be 200
    And response should be name = Crowdar
    * define projectId = response.id
    * define workspaceId = response.workspaceId