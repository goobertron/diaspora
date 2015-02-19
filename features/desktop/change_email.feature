@javascript
Feature: Change email

  Scenario: Change my email
    Given I am signed in
    When I go to the users edit page
    And I fill in the following:
      | user_email         | new_email@newplac.es           |
    And I submit the change email form
    Then I should see the text for "users.update.unconfirmed_email_changed"
    When I follow the "confirm_email" link from the last sent email
    Then I should see the text for "users.confirm_email.email_confirmed"
    And my "email" should be "new_email@newplac.es"
