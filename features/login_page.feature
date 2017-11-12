Feature: Login Page
  As a User
  I want to be able to login or create an account
  So that I can access my account
  
Scenario: User Logs In 
  Given I have registered
  When I go to the login page
  And I enter my information
  Then I should be taken to my projects page

Scenario: User Fails Login
  When I go to the login page
  And I enter wrong information
  Then I should be taken to the login page
  
Scenario: User Clicks Register
  When I go to the login page
  And I click register
  Then I should be taken to the register page
