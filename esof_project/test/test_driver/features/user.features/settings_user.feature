Feature: Change user info
  Users should be able to change their account's information by accessing the settings tab and pressing
  the change settings button.

  Scenario: Change Password
    Given I'm in the settings tab
    When I press the "change Password" button
    And I enter my current password
    And I enter my new password
    And I confirm my new password
    And I press the "Save" button
    Then I change my password