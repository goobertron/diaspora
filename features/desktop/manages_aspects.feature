@aspects @javascript
Feature: User manages contacts
  In order to share with a limited group
  As a User
  I want to create new aspects

  Scenario: creating an aspect from contacts index
    Given I am signed in
    And I am on the contacts page
 
    When I follow "Add an aspect"
    And I fill in "Name" with "Dorm Mates" in the modal window
    And I submit the form in the modal window
    Then I should see "Dorm Mates" within "#aspect_nav"

  Scenario: creating an aspect from homepage
    Given I am signed in
    And I go to the aspects page

    When I click on selector "#add_aspect"
    And I fill in "Name" with "losers" in the modal window
    And I submit the form in the modal window
    Then I should see "losers" within "#aspect_nav"

  Scenario: deleting an aspect from contacts index
    Given I am signed in
    And I have an aspect called "People"
    And I am on the contacts page

    When I follow "People"
    And I click on selector "#delete_aspect"
    And I confirm the alert
    Then I should be on the contacts page
    And I should not see "People" within "#aspect_nav"

  Scenario: deleting an aspect from homepage
    Given I am signed in
    And I have an aspect called "People"
    And I am on the aspects page

    When I click on "People" aspect edit icon
    And I click on selector "#delete_aspect"
    And I confirm the alert
    Then I should be on the contacts page
    And I should not see "People" within "#aspect_nav"

  Scenario: Editing the aspect memberships of a contact from the contacts page
    Given I am signed in
    And I have 2 contacts
    And I have an aspect called "Cat People"
    And I am on the contacts page

    When I follow "Cat People"
    And I add the first person to the aspect
    Then I should have 1 contact in "Cat People"

    When I remove the first person from the aspect
    Then I should have 0 contacts in "Cat People"

  Scenario: Renaming an aspect
    Given I am signed in
    And I have an aspect called "Cat People"
    And I am on the contacts page

    When I follow "Cat People"
    And I click on selector "#change_aspect_name"
    And I fill in "aspect_name" with "Unicorn People"
    And I submit the form
    Then I should see "Unicorn People" within "#aspect_name"

  Scenario: clicking on the contacts link in the header with zero contacts directs a user to the featured users page
    Given I am signed in
    And I have 0 contacts
    And I am on the home page

    When I click on my name in the header
    And I click on selector "#contacts"
    Then I should see the text for "aspects.no_contacts_message.community_spotlight" within ".span9"

  Scenario: clicking on the contacts link in the header with contacts does not send a user to the featured users page
    Given I am signed in
    And I have 2 contacts
    And I am on the home page

    When I click on my name in the header
    And I click on selector "#contacts"
    Then I should not see the text for "aspects.no_contacts_message.community_spotlight" within ".span9"
