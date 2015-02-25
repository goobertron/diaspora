@javascript
Feature: Change password

  Scenario: Change my password
    Given I am signed in
    When I go to the users edit page
    And I fill out the change password section with my password and "newsecret" and "newsecret"
    And I submit the change password form
    Then I should see the text for "users.update.password_changed"
    Then I should be on the new user session page
    When I sign in with password "newsecret"
    Then I should be on the stream page

  Scenario: Reset my password
    Given a user with email "forgetful@users.net"
    Given I am on forgot password page
    When I fill out the forgot password form with "forgetful@users.net"
    And I submit the forgot password form
    Then I should see the text for "devise.passwords.send_instructions"
    When I follow the "devise.mailer.reset_password_instructions.change" link from the last sent email
    Then I should see the text for "devise.passwords.edit.new_password"
    When I fill out the reset password form with "supersecret" and "supersecret"
    And I submit the reset password form
    Then I should be on the stream page

  Scenario: Attempt to reset password with invalid email
    Given I am on forgot password page
    When I fill out the forgot password form with "notanemail"
    And I submit the forgot password form
    Then I should see the text for "devise.passwords.new.no_account"
