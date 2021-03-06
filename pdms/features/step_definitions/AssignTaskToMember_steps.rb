Given(/^there is a task$/) do
  @project = FactoryGirl.create :project
  @task = FactoryGirl.create :task
  @document_template = FactoryGirl.create :document_template
end

Given(/^I want to add a task to a member$/) do
  @team_member = FactoryGirl.create :team_member
  @project.users << @team_member
end

When(/^I visit the assign task page$/) do
   @assign_task_link = find_link('Assign Task', href: "#{assigntaskindex_path(@project)}?project_id=#{@project.id}")
   @assign_task_link.click 
   #save_and_open_page
end

Then(/^I should see a form to add a task to a member$/) do
  expect(page).to have_selector 'form select#doctmpl_id'
  expect(page).to have_selector 'form select#approver_id'
  expect(page).to have_selector 'form select#assignee_id'
  expect(page).to have_selector "form input[type=submit][value='Assign task']"
end

When(/^I submit the "([^"]*)" form$/) do |arg1|
  select "#{@team_member.firstName} #{@team_member.lastName}", from: "assignee_id"
  click_button "Assign task"
end

Then(/^I should see the details of the task list$/) do
  expect(page).to have_selector 'tr[id^=rowTaskId_]'
end

Then(/^I should see the task added to the member$/) do
  expect(find('tr[id^=rowTaskId_]')).to have_content "#{@team_member.firstName} #{@team_member.lastName}"
end

