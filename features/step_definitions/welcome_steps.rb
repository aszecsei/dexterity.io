When(/^I go to the homepage$/) do
  visit root_path
end

Then(/^I should see the welcome message$/) do
  expect(page).to have_content("Dexterity is a free agile tracking software focused on usablility
                        and teamwork. It is designed to both be a simple and cost-effecive 
                        tool with powerful features for the aspiring start-up. Click above 
                        to get started.")
end

Given(/^I am on the homepage$/) do
  visit root_path
end

When(/^I click the 'Get Started' button$/) do
  click_on "get-started-btn"
end

Then(/^I should be taken to the login page$/) do
  expect(page).to have_field("email")
  expect(page).to have_field("password")
  expect(page).to have_content("Login")
end