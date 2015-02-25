@javascript
Feature: Invitations

    Scenario: accept invitation from admin
      Given I have been invited by an admin
      And I am on my acceptance form page
      And I fill in the new user form
      And I submit the form
      Then I should be on the getting started page
      And I should see the text for "users.getting_started.well_hello_there"
      And I fill in the following:
        | profile_first_name         | O             |

      And I follow "awesome_button"
      And I confirm the alert
      Then I should be on the stream page
      And I close the publisher

    Scenario: accept an email invitation
      When I visit alice's invitation code url
      # Then I should see the "alice is excited" message
      When I fill in the new user form
      And I submit the form
      Then I should see the "welcome to diaspora" message
      And I should be able to friend Alice

    Scenario: accept invitation from user
      Given I have been invited by bob
      And I am on my acceptance form page
      And I fill in the new user form
      And I submit the form
      Then I should be on the getting started page
      And I should see the text for "users.getting_started.well_hello_there"
      And I fill in the following:
        | profile_first_name         | O             |

      And I follow "awesome_button"
      And I confirm the alert
      Then I should be on the stream page
      And I close the publisher
      And I sign out
      And I sign in as "bob@bob.bob"
      And I click on selector "#invite_email"
      Then I should see one less invite

    Scenario: sends an invitation
      Given a user with email "bob@bob.bob"
      When I sign in as "bob@bob.bob"
      And I click on selector "#invite_email"
      And I fill in the following:
        | email_inviter_emails         | alex@example.com    |
      And I submit the form
      Then I should have 1 Devise email delivery
      And I should not see "notifier.to_change_your_notification_settings" in the last sent email
