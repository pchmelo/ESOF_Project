Feature: Add a product to a shopping list
  Users should be able to add a product to a shopping list when the add product button is tapped

  Scenario Outline: Add product to shopping list
    Given I'm in the shopping list tab
    When I tap the list I wish to remove
    And I tap the three vertical dots button in the top-right corner
    And I tap "Add product"
    And I select the product I wish to add
    And I insert the <quantity> of the product I wish to buy
    Then the the product gets added to the list

      Examples:
        | quantity |
        | 1        |
        | 2        |
        | 3        |