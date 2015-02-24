@javascript
Feature: Naviguate between pages using the header menu and the drawer
  As a user
  I want to be able naviguate between the pages of the mobile version

  Background:
    Given following users exist:
      | username     | email             |
      | Bob Jones    | bob@bob.bob       |
      | Alice Smith  | alice@alice.alice |
      
    And I sign in as "alice@alice.alice"
    And a user with email "bob@bob.bob" is connected with "alice@alice.alice"
    And I search for "#boss"
    And I press "Follow #boss"
    And I toggle the mobile view
    
  Scenario: naviguate to the activity stream page
    When I open the drawer
    And I click on selector "#my_activity"
    Then I should see the text for "stream_helper.no_posts_yet" within "#main_stream"
    
  Scenario: naviguate to the notification page
    When I click on selector "#notification_badge"
    Then I should see the text for "notifications.index.notifications" within "#main"
    
  Scenario: naviguate to the conversation page
    When I click on selector "#conversations_badge"
    Then I should see the text for "conversations.index.inbox" within "#main"
    
  Scenario: naviguate to the publisher page
    When I click on selector "#compose_badge"
    Then I should see the text for "all_aspects" within "#new_status_message"
    
  Scenario: search a user
    When I open the drawer
    And I search for "Bob"
    Then I should see the text for "people.index.results_for" within "#search_title"
    And I should see "Bob" within "#search_title"
    
  Scenario: search for a tag
    When I open the drawer
    And I search for "#bob"
    Then I should see "#bob" within "#main > h1"
    
  Scenario: naviguate to my activity page
    When I open the drawer
    And I click on selector "#my_activity"
    Then I should see the text for "javascripts.my_activity" within "#main"
    
  Scenario: naviguate to my mentions page
    Given Alice has a post mentioning Bob
    And I sign in as "bob@bob.bob"    
    When I open the drawer
    And I click on selector "#mentions"
    Then I should see "Bob Jones" within ".stream_element"
    
  Scenario: naviguate to my aspects page
    Given "bob@bob.bob" has a public post with text "bob's text"
    When I open the drawer
    And I click on selector "#all_aspects"
    Then I should see "Besties" within "#all_aspects + li > ul"
    And I follow "Besties"
    Then I should see "bob's text" within "#main_stream"
    
  Scenario: naviguate to the followed tags page
    Given "bob@bob.bob" has a public post with text "bob is da #boss"
    When I open the drawer
    And I click on selector "#followed_tags"
    Then I should see "#boss" within "#followed_tags + li > ul"
    And I follow "#boss"
    Then I should see "bob is da #boss" within "#main_stream"
    
  Scenario: naviguate to my profile page
    When I open the drawer
    And I click on selector "#profile"
    Then I should see "Alice" within "#author_info"
    
  Scenario: naviguate to my mentions page
    When I open the drawer
    And I click on selector "#contacts"
    Then I should see the text for "_contacts" within "#main"
    
  Scenario: naviguate to my mentions page
    When I open the drawer
    And I click on selector "#settings"
    Then I should see the text for "settings" within "#main"
