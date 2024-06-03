Feature: Project

  Background:
    Given base url https://api.clockify.me/api
    And header x-api-key = $(env.x_api_key)


  @addaNewProject
  Scenario: Crear un proyecto dentro del workspace exitosamente
    * define WSID = 664c098f7d59624baae8205e
    And endpoint /v1/workspaces/{{WSID}}/projects
    And header Content-Type = application/json
    And set value "Hamburguesa" of key name in body jsons/bodies/AddProject.json
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

  @getAllProjectsOnWorkspace
  Scenario: Obtener proyecto de un Workspace filtrado por Param Name exitosamente
    * define WSID = 664c098f7d59624baae8205e
    And endpoint /v1/workspaces/{{WSID}}/projects
    And param name = Hamburguesa
    When execute method GET
    Then the status code should be 200

  @updateProjectOnWorkspaceColor
  Scenario: Actualizar color de un proyecto exitosamente
    * define WSID = 664c098f7d59624baae8205e
    * define PRJCT = 6653dcde7fdd88505a6133eb
    And endpoint /v1/workspaces/{{WSID}}/projects/{{PRJCT}}
    And set value "#FF5722" of key color in body jsons/bodies/updateColor.json
    And header Content-Type = application/json
    When execute method PUT
    Then the status code should be 200
    And response should be color = #FF5722

  @addaNewProjectError401
  Scenario: Fallo al crear un proyecto por API KEY incorrecta
    * define WSID = 664c098f7d59624baae8205e
    And header x-api-key = NjBhNjU4MGUtMDI0Zi00M2EwLWEyNTgtYmE4NTcwMWY1YWQ
    And endpoint /v1/workspaces/{{WSID}}/projects
    And header Content-Type = application/json
    And set value "Hamburguesa" of key name in body jsons/bodies/AddProject.json
    When execute method POST
    Then the status code should be 401

  @addaNewProjectError404
  Scenario: Fallo al crear un proyecto por ENDPOINT incompleto
    * define WSID = 664c098f7d59624baae8205e
    And endpoint /{{WSID}}/projects
    And header Content-Type = application/json
    And set value "Hamburguesa" of key name in body jsons/bodies/AddProject.json
    When execute method POST
    Then the status code should be 404

  @findProjectByIdError400
  Scenario: Fallo al consultar un proyecto por ID incorrecto
    And endpoint /v1/workspaces/664c098f7d59624baae8205e/projects/664c0e50f00
    When execute method GET
    Then the status code should be 400