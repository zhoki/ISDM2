Feature: AssignTaskToMember

  In order to seperate works among team members, as a project manager, 
  I want to assign tasks in the project to members.

  Scenario: Assign tasks to members

    A project manager should be able to assign tasks to members

    Given I am a project manager
    And there is a task
    And I want to add a task to a member
    And I am signed in
    When I visit the projects page
    Then I should see the project listing
    When I click the link for the project
    Then I should then I should see the details of my project
    When I visit the assign task page
    Then I should see a form to add a task to a member
    When I submit the "assign task" form
    Then I should see the details of the task list
    And I should see the task added to the member
