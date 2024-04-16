Feature: Remove products
  Users should be able to remove a product from the stock when the remove button is tapped in the
  product info tab.

  Scenario: Remove a product
    Given I'm in the stock tab
    When I tap the product I want to remove
    And I tap the three dots button in the top-right corner
    And I tap "Remove"
    Then the product gets removed from the stock