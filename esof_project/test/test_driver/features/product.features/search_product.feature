Feature: Search products
  Users should be able to search for products in the stock tab by using the search bar.

  Scenario Outline: Search for a product
    Given I'm in the Stock tab
    When I tap the search bar
    And I insert the <name> of an existing product
    And I tap the "search" icon
    Then the product appears in the screen

    Examples:
      | name    |
      | "Beans" |
      | "Bread" |