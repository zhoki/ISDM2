Feature: Submit task for approval
    Member who is a member of a project is assigned a task by the project manager of that project
    Member has uploaded document files which is associated to the task
    Member decides to notify project manager to review the document authored by this member
    Only the member who is owner of the task concerning this document can submit it for approval

Scenario: Submit task for approval
  Given I am a team member
  And I am signed in as a team member
  And there is a project
  And I am a member of the project
  And there is a task assigned to me
  When I visit the tasks page
  Then I should see a row of table that shows information of the task assigned to me
  And status of the task should be "in progress"
  And I should see the link to submit the task for approval
  When I click link "Send for approval"
  Then status of the task should be changed to "Submitted for approval"