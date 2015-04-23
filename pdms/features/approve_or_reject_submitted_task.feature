Feature: Approve or reject submitted task
    Project manager needs to review the document (which is binded to a task in a project) submitted by team member
    Tasks that project manager can work on must be of status 'Submitted for approval'
    Project manager can either approve or reject document attached to the task
    Task that is approved will have its status changed to 'Approved'
    Task that is rejected will have its status changed to 'Revise'

Scenario: Project Manager approves the submitted task
  Given I am a project manager
  And I am signed in
  And there is a project
  And there is a task submitted for approval
  When I visit the projects page
  Then I should see the project listing
  When I click the link for the project
  Then I should then I should see the details of my project
  And I should see the link to the page that lists tasks created in this project
  When I click the link to the page that lists tasks created in this project
  Then I should see the task a team member submitted for approval
  And I should see a button that says Respond
  When I click the Respond button
  Then a modal dialogue for approving or rejecting task should appear
  When I choose to approve this task and click Respond button
  Then the status of the task should be changed to Approved

Scenario: Project Manager rejects the submitted task
  Given I am a project manager
  And I am signed in
  And there is a project
  And there is a task submitted for approval
  When I visit the projects page
  Then I should see the project listing
  When I click the link for the project
  Then I should then I should see the details of my project
  And I should see the link to the page that lists tasks created in this project
  When I click the link to the page that lists tasks created in this project
  Then I should see the task a team member submitted for approval
  And I should see a button that says Respond
  When I click the Respond button
  Then a modal dialogue for approving or rejecting task should appear
  When I choose to reject this task, fill in remarks, and click Respond button
  Then the status of the task should be changed to Revise