@javascript
Feature: preview posts in the stream
    In order to test markdown without posting
    As a user
    I want to see a preview of my posts in the stream

    Background:
      Given following users exist:
        | username     | email             |
        | Bob Jones    | bob@bob.bob       |
        | Alice Smith  | alice@alice.alice |
      And a user with email "bob@bob.bob" is connected with "alice@alice.alice"
      When I sign in as "bob@bob.bob"
      And I am on the home page
      Then I should not see any posts in my stream

    Scenario: preview and post a text-only message
      Given I expand the publisher
      When I write the status message "I am eating yogurt"
      And I preview the post
      Then "I am eating yogurt" should be post 1
      And the first post should be a preview

      When I write the status message "This preview rocks"
      And I preview the post
      Then "This preview rocks" should be post 1
      And I should not see "I am eating a yogurt"

      When I write the status message "I like rocks"
      And I submit the publisher
      Then "I like rocks" should be post 1
      And I should not see "This preview rocks"

    Scenario: preview a very long message
      Given I expand the publisher
      When I insert an extremely long status message
      And I preview the post
      Then the preview should not be collapsed

      When I submit the publisher
      Then the post should be collapsed

    Scenario: preview a photo with text
      Given I expand the publisher
      And I attach "spec/fixtures/button.png" to the publisher
      When I fill in the following:
          | status_message_fake_text    | Look at this dog    |
      And I preview the post
      Then I should see an "img" within ".stream_element div.photo_attachments"
      And I should see "Look at this dog" within ".stream_element"
      And I close the publisher

    Scenario: preview a post with mentions
      Given I expand the publisher
      And I mention Alice in the publisher
      And I preview the post
      And I follow "Alice Smith"
      And I confirm the alert
      Then I should see "Alice Smith"

    Scenario: preview a post on tag page
      Given there is a user "Samuel Beckett" who's tagged "#rockstar"
      When I search for "#rockstar"
      Then I should be on the tag page for "rockstar"
      And I should see "Samuel Beckett"
      Given I expand the publisher
      When I fill in the following:
          | status_message_fake_text    | This preview rocks    |
      And I preview the post
      Then "This preview rocks" should be post 1
      And the first post should be a preview
      And I close the publisher

    Scenario: preview a post with the poll
      Given I expand the publisher
      When I fill in the following:
          | status_message_fake_text    | I am eating yogurt    |
      And I press the element "#poll_creator"
      When I fill in the following:
          | status_message_fake_text    | I am eating yogurt |
          | poll_question               | What kind of yogurt do you like? |
      And I fill in the following for the options:
          | normal |
          | not normal  |
      And I preview the post
      Then I should see a ".poll_form" within ".stream_element"
      And I should see a "form" within ".stream_element"
      And I close the publisher
