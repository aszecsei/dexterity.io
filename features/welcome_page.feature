Feature: Welcome Page
  As a user
  I want to be greeted when I visit the site
  So that I know what the site does

Scenario: User sees the welcome message
  When I go to the homepage
  Then I should see the welcome message

Scenario: User clicks the 'Get Started' button
  Given I am on the homepage
  When I click the 'Get Started' button
  Then I should be taken to the login page
  