Given(/^I am a team member$/) do
  @team_member = FactoryGirl.create :team_member
  @project_manager = FactoryGirl.create :project_manager
  @project = FactoryGirl.build :project
end

Given(/^I am signed in as a team member$/) do
  visit '/users/sign_in'
  fill_in 'Email', with: @team_member.email
  fill_in 'Password', with: @team_member.password

  click_button 'Log in'
end

Given(/^I am a member of the project$/) do
  @project.users << @team_member
  expect(@team_member.in? @project.users).to be true
end

Given(/^there is a task assigned to me$/) do
  @task = FactoryGirl.create :task
  @task.approver = @project_manager
  @task.assignee = @team_member
  @task.project = @project
  @project.tasks << @task
  puts "Task status: #{@task.task_status.id}"
  puts "Task assignee: #{@task.assignee.id}"
  puts "Task approver: #{@task.approver.id}"
end

When(/^I visit the tasks page$/) do
  visit '/tasks'
end

Then(/^I should see a row of table that shows information of the task assigned to me$/) do
  expect(page).to have_content @task.document_template.name
  expect(page).to have_content @task.approver.firstName
  expect(page).to have_content @task.approver.lastName
  expect(page).to have_content @task.assignee.firstName
  expect(page).to have_content @task.assignee.lastName
end

Then(/^status of the task should be "([^"]*)"$/) do |arg1|
  expect(page).to have_content @task.task_status.name
end

Then(/^I should see the link to submit the task for approval$/) do
  expect(find_link('Send for approval').visible?).to be true
end

When(/^I click link "([^"]*)"$/) do |arg1|
  find_link('Send for approval').click
end

Then(/^status of the task should be changed to "([^"]*)"$/) do |arg1|
  expect(page).to have_content 'Submitted for approval'
  # save_and_open_page
end