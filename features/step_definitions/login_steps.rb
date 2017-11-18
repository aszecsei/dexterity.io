Given(/^I have registered/) do
    visit register_path
    fill_in('username', :with => 'Testing')
    fill_in('email', :with => 'Testing@testing.test')
    fill_in('displayName', :with => 'Testing')
    fill_in('password', :with => 'Testing')
    fill_in('confirmpassword', :with => 'Testing')
    click_button('register-button')
end

When(/^I go to the login page$/) do
  visit login_path
end

And(/^I enter my information$/) do
    fill_in('username', :with => 'Testing')
    fill_in('password', :with => 'Testing')
    click_button('login_button')
end

Then(/^I should be taken to my projects page/) do
    expect(page).to have_content("Projects")
end
And(/^I enter wrong information$/) do
    fill_in('username', :with => 'aaaaaaa')
    fill_in('password', :with => 'ssssssss')
    click_button('login_button')
end


And(/^I click register$/) do
  click_on('register-button')
end

Then(/^I should be taken to the register page$/) do
  expect(page).to have_field("username")
  expect(page).to have_field("password")
  expect(page).to have_content("Register")
end
