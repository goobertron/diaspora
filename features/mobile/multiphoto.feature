@javascript
Feature: viewing photos on the mobile main page
  In order to navigate Diaspora*
  As a mobile user
  I want to view some photos

  Background:
    Given a user with username "bob"

    When I toggle the mobile view
    And I sign in as "bob@bob.bob" on the mobile website
    And I click on selector "#compose_badge"
    And I attach the file "spec/fixtures/button.png" to hidden "file" within "#file-upload-publisher"

  Scenario: view full size image
    When I submit the mobile publisher
    And I click on selector "img.stream-photo"
    Then I should see an "img" within "#show_content"
    And I should not see a "#right" within "#main"

  Scenario: view multiphoto post
    When I attach the file "spec/fixtures/button.gif" to hidden "file" within "#file-upload-publisher"
    And I submit the mobile publisher
    Then I should see "+ 1" within ".additional_photo_count"

    When I click on selector "img.stream-photo"
    Then I should see a "#right" within "tbody"

    When I click on selector "img#arrow-right"
    And I should see a "#left" within "tbody"
    And I should not see a "#right" within "tbody"
