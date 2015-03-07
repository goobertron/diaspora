@javascript
Feature: private conversations
    In order to be talkative
    As a User
    I want to converse with people

  Background:
    Given a user named "Robert Grimm" with email "bob@bob.bob"
    And a user named "Alice Awesome" with email "alice@alice.alice"
    And a user with username "robert_grimm" is connected with "alice_awesome"
    Given I sign in as "bob@bob.bob"

  Scenario: start a conversation
    When I send a message with subject "Greetings" and text "Hello, Alice!" to "Alice Awesome"
    Then I should see "Greetings" within "#conversation_inbox"
    And I should see "Greetings" within "#conversation_show"
    And I should see "less than a minute ago" within "#conversation_inbox"
    And I should see "less than a minute ago" within "#conversation_show"
    And I should see "Alice Awesome" as a participant
    And "Alice Awesome" should be part of active conversation
    And I should see "Hello, Alice!" within ".stream_container"

  Scenario: view and reply to a conversation
    When I send a message with subject "Greetings" and text "Hello, Alice!" to "Alice Awesome"
    And I sign out
    When I sign in as "alice@alice.alice"
    And I am on the conversations page
    Then I should see "Greetings" within "#conversation_inbox"
	When I press the first ".conversation" within ".conversations"
    Then I should see "Greetings" within "#conversation_show"
    And I should see "Robert Grimm" as a participant
    And "Robert Grimm" should be part of active conversation
    And I should see "Hello, Alice!" within ".stream_container"
    When I reply with "Hey, how you doing?"
    Then I should see "Hey, how you doing?" within ".stream_container"

  Scenario: hide and mute a conversation
    When I send a message with subject "Greetings" and text "Hello, Alice!" to "Alice Awesome"
    And I sign out
    When I sign in as "alice@alice.alice"
    And I am on the conversations page
    Then I should see "Greetings" within "#conversation_inbox"
	When I press the first ".conversation" within ".conversations"
    And I press the ".close_conversation" button
    And I confirm the alert
    Then I should not see "Greetings" within "#conversation_inbox"