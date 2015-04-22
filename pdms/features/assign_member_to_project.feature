Feature: Assign member to project
    Member should not be added into the project before the project is created
    Member who is already in the project cannot be added into the project
    Only project managers can assign members to project they are in charge of
    If there is no available members to add, project manager should not be able to perform this feature

Scenario: Add available member to a project
    Given I am a project manager
    And I am signed in
    And there is a project
    And I want to add an available member into this project
    When I visit the projects page
    Then I should see the project listing
    When I click the link for the project
    Then I should then I should see the details of my project
    And I should see the link to a page for adding a new member to my project
    When I click the link to a page for adding a new member
    Then I should see the form to add a new member
    And I should see the list of team members
    And I select the team member I want to add
    When I submit the form
    Then I should see the list of team members
    And I should see the member I just added in the list
