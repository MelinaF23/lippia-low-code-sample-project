Feature: Project

  @addaNewProject
  Scenario: Proyecto creado exitosamente
    Given base url https://api.clockify.me/api
    And endpoint /v1/workspaces/664c098f7d59624baae8205e/projects
    And header Content-Type = application/json
    And header x-api-key = NjBhNjU4MGUtMDI0Zi00M2EwLWEyNTgtYmE4NTcwMWY1YWQ5
    And set value "Eliminar 3" of key name in body jsons/bodies/AddProject.json
    When execute method POST
    Then the status code should be 201
