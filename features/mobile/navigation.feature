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
    
  Scenario: navigate to the notification page
    When I click on selector "#notification_badge"
    Then I should see the text for "notifications.index.notifications" within "#main"
    
  Scenario: navigate to the conversation page
    When I click on selector "#conversations_badge"
    Then I should see the text for "conversations.index.inbox" within "#main"
    
  Scenario: navigate to the publisher page
    When I click on selector "#compose_badge"
    Then I should see the text for "all_aspects" within "#new_status_message"
    
  Scenario: search for a user
    When I open the drawer
    And I search for "Bob"
    Then I should see the text for "people.index.results_for" within "#search_title"
    And I should see "Bob" within "#search_title"
    
  Scenario: search for a tag
    When I open the drawer
    And I search for "#bob"
    Then I should see "#bob" within "#main > h1"
    
  Scenario: navigate to my activity page
    When I open the drawer
    And I follow the "#my_activity" link
    Then I should see the text for "javascripts.my_activity" within "#main"
    And I should see the text for "stream_helper.no_posts_yet" within "#main_stream"
    
  Scenario: navigate to my mentions page
    Given Alice has a post mentioning Bob
    And I sign in as "bob@bob.bob"    
    When I open the drawer
    And I follow the "#mentions" link
    Then I should see "Bob Jones" within ".stream_element"
    
  Scenario: navigate to my aspects page
    Given "bob@bob.bob" has a public post with text "bob's text"
    When I open the drawer
    And I follow the "#all_aspects" link
    Then I should see "Besties" within "#all_aspects + li > ul"
    And I follow "Besties"
    Then I should see "bob's text" within "#main_stream"
    
  Scenario: navigate to the followed tags page
    Given "bob@bob.bob" has a public post with text "bob is da #boss"
    When I open the drawer
    And I follow the "#followed_tags" link
    Then I should see "#boss" within "#followed_tags + li > ul"
    And I follow "#boss"
    Then I should see "bob is da #boss" within "#main_stream"
    
  Scenario: navigate to my profile page
    When I open the drawer
    And I follow the "#profile" link
    Then I should see "Alice" within "#author_info"
    
  Scenario: navigate to my mentions page
    When I open the drawer
    And I follow the "#contacts" link
    Then I should see the text for "_contacts" within "#main"
    
  Scenario: navigate to my mentions page
    When I open the drawer
    And I follow the "#settings" link
    Then I should see the text for "settings" within "#main"
