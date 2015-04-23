Given(/^there is a task submitted for approval$/) do
  @task = FactoryGirl.build :task
  @project_manager = FactoryGirl.build :project_manager
  @team_member = FactoryGirl.build :team_member

  @task.approver = @project_manager
  @task.assignee = @team_member
  @task.project = @project
  @task.task_status = FactoryGirl.build :submitted_for_approval_status
  @project.tasks << @task

  puts "Task id #{@task.id} approver #{@task.approver.firstName} assignee #{@task.assignee.firstName} project #{@task.project}"
end

Then(/^I should see the link to the page that lists tasks created in this project$/) do
  @tasksLink = find_link 'Tasks', href: "#{tasklist_path(@project)}?project_id=#{@project.id}"
  expect(@tasksLink.visible?).to be true
end

When(/^I click the link to the page that lists tasks created in this project$/) do
  @tasksLink.click
end

Then(/^I should see the task a team member submitted for approval$/) do
  expect(page).to have_selector("tr#rowTaskId_#{@task.id}")
  expect(page).to have_content "#{@team_member.firstName} #{@team_member.lastName}"
  expect(page).to have_content @task.document_template.name
end

Then(/^I should see a button that says Respond$/) do
  expect(page).to have_selector("a.btnRespondTask")
  @respondLink = find_link("Respond", href: "#")
end

When(/^I click the Respond button$/) do
  @respondLink.click
end

Then(/^a modal dialogue for approving or rejecting task should appear$/) do
  expect(page).to have_selector 'div.modal-dialog'
end

When(/^I choose to approve this task and click Respond button$/) do
  select "Approved", from: "respondedStatusID"
  find('input[type=submit]#btnSubmitResponse').click
end

Then(/^the status of the task should be changed to Approved$/) do
  expect(page).to have_selector('p.label.label-success')
  expect(find('p.label.label-success')).to have_content('Approved')
end

When(/^I choose to reject this task, fill in remarks, and click Respond button$/) do
  select "Revise", from: "respondedStatusID"
  fill_in "Remarks", with: "A testing remark from cucumber testing!"
  find('input[type=submit]#btnSubmitResponse').click
end

Then(/^the status of the task should be changed to Revise$/) do
  expect(page).to have_selector('p.label.label-danger')
  expect(find('p.label.label-danger')).to have_content('Revise')
end
