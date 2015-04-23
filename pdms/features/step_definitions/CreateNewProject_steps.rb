Then(/^I should see a button "([^"]*)"$/) do |arg1|
  #save_and_open_page
  expect(page).to have_content "New Project"
end

When(/^I click the button "([^"]*)"$/) do |arg1|
  click_link 'New Project'
end

Then(/^I should see a form to create new project$/) do
   expect(page).to have_selector 'form input#project_name'
   expect(page).to have_selector 'form textarea#project_description'
   expect(page).to have_selector 'form select#project_startDate_1i'
   expect(page).to have_selector 'form select#project_startDate_2i'
   expect(page).to have_selector 'form select#project_startDate_3i'
   expect(page).to have_selector 'form select#project_dueDate_1i'
   expect(page).to have_selector 'form select#project_dueDate_2i'
   expect(page).to have_selector 'form select#project_dueDate_3i'
end

When(/^I submit the form "([^"]*)"$/) do |arg1|
  click_button "Confirm"
end

Then(/^I should see the details of my project$/) do
  expect(page).to have_content "Basic Info"
end


