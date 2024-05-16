Feature: Receive alerts when a product's expiration date is near
  Users should receive alerts about products that are soon to expire when they specify the date and
  witch products they want to be notified about.

  Scenario: Adding alert for an existing product
    Given I'm in the product with expiration date's info screen
    When I tap the three vertical dots button in the top right corner
    And I tap "Edit" button
    And I check the "Notification" checkbox
    And I insert the number of days/weeks/months before the expiration date that I want to be notified
    Then the alert for the product is added

  Scenario: Adding alert for a new product
    Given I'm creating a new product with expiration date
    When I insert the product's expiration date
    And I insert the number of days/weeks/months before the expiration date that I want to be notified
    Then the alert for the product is added

  Scenario: Editing alert for an existing product
    Given I'm in the product with expiration date's info screen
    When I tap the three vertical dots button in the top right corner
    And I tap "Edit Notifications" button
    And I change the number of days/weeks/months before the expiration date that I want to be notified
    Then the alert for the product is updated

  Scenario: Receive alert
    Given the current date is the day the user wished to be notified before the expiration date of a product
    When I go to the setttings tab
    And I tap "Alerts"
    Then an alert should  be in there notifying me of the product that is soon to expire