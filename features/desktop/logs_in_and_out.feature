@javascript
Feature: user authentication

  Scenario: user logs in
    Given a user with username "ohai" and password "secret"
    When I sign in manually as "ohai" with password "secret"
    Then I should be on the stream page

  Scenario: user logs out
    Given I am signed in
    And I sign out manually
    Then I should be on the new user session page
