Given(/^I am a project manager$/) do
  @project_manager = FactoryGirl.create :project_manager
end

Given(/^I am signed in$/) do
  visit '/users/sign_in'
  fill_in 'Email', with: @project_manager.email
  fill_in 'Password', with: @project_manager.password

  click_button 'Log in'
end

Given(/^there is a project$/) do
  @project = FactoryGirl.create :project
end

Given(/^I want to add an available member into this project$/) do
  @team_member = FactoryGirl.create :team_member
  expect(@team_member.in?(@project.users)).to be false
end

When(/^I visit the projects page$/) do
  visit '/projects'
end

Then(/^I should see the project listing$/) do
  expect(page).to have_selector 'table.table'
  expect(page).to have_content 'Project Name'
end

When(/^I click the link for the project$/) do
  find_link(@project.name, href: project_path(@project)).click
end

Then(/^I should then I should see the details of my project$/) do
  expect(page).to have_content @project.name
  expect(page).to have_content @project.description
  expect(page).to have_content @project.pm
end

Then(/^I should see the link to a page for adding a new member to my project$/) do
  @members_link = find_link('Members', href: "#{member_path(@project)}?project_id=#{@project.id}")
end

When(/^I click the link to a page for adding a new member$/) do
  @members_link.click
end

Then(/^I should see the form to add a new member$/) do
  # save_and_open_page
  expect(page).to have_selector 'form select#user_id'
  expect(page).to have_selector 'form input[type=submit][value=Add]'
end

Then(/^I should see the list of team members$/) do
  expect(page).to have_selector 'ul.list-group'
end

Then(/^I select the team member I want to add$/) do
  select @team_member.firstName, from: "user_id"
end

When(/^I submit the form$/) do
  click_button "Add"
end

Then(/^I should see the member I just added in the list$/) do
  expect(page).to have_content "#{@team_member.firstName} #{@team_member.lastName}"
end
