@javascript
Feature: invitation acceptance
    Scenario: accept invitation from admin
      Given I have been invited by an admin
      And I am on my acceptance form page
      And I fill in the new user form
      And I submit the form
      Then I should be on the getting started page
      And I should see I18n.t("users.getting_started.well_hello_there")
      And I fill in the following:
        | profile_first_name         | O             |

      And I follow "awesome_button"
      And I confirm the alert
      Then I should be on the stream page
      And I close the publisher

    Scenario: accept invitation from user
      Given I have been invited by bob
      And I am on my acceptance form page
      And I fill in the new user form
      And I submit the form
      Then I should be on the getting started page
      And I should see I18n.t("users.getting_started.well_hello_there")
      And I fill in the following:
        | profile_first_name         | O             |

      And I follow "awesome_button"
      And I confirm the alert
      Then I should be on the stream page
      And I close the publisher
      And I log out
      And I sign in as "bob@bob.bob"
      And I follow "Invite someone"
      Then I should see one less invite

    Scenario: sends an invitation
      Given a user with email "bob@bob.bob"
      When I sign in as "bob@bob.bob"
      And I follow "Invite someone"
      And I fill in the following:
        | email_inviter_emails         | alex@example.com    |
      And I submit the form
      Then I should have 1 Devise email delivery
      And I should not see "notifier.to_change_your_notification_settings" in the last sent email
