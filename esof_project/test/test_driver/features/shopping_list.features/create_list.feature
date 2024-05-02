Feature: Create a shopping list
  Users should be able to create a shopping list when the create new list button is tapped

  Scenario Outline: Create shopping list
    Given I'm in the shopping list tab
    When I tap the "+" in front of the last created list
    And I insert a <name>
    And I tap "Confirm"
    Then a new list is created with that name

    Examples:
      |      name       |
      | Groceries       |
      | BBQ with family |
      | Pool Party      |