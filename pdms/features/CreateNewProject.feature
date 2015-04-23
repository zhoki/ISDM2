Feature: Create New Project

  In order to implement the project, as a project manager, 
  I want to create new project.

  Scenario: Create new projects

    A project manager should be able to create new projects

    Given I am a project manager
    And I am signed in
    When I visit the projects page
    Then I should see a button "create new project"
    When I click the button "create new project"
    Then I should see a form to create new project
    When I submit the form "create new project" 
    Then I should see the details of my project
  
