Feature: Remove a shopping list
  Users should be able to remove a shopping list when the delete list button is tapped

  Scenario: Delete shopping list
    Given I'm in the shopping list tab
    When I tap the list I wish to remove
    And I tap the three vertical dots button in the top-right corner
    And I tap "Delete"
    Then the list is removed from the shopping list tab