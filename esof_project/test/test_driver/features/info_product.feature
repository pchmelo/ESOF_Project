Feature: See products' info
  Users should be able to remove a product from the stock when the remove button is tapped in the
  product info tab.

  Scenario: Remove a product
    Given I'm in the stock tab
    When I tap the product I want to inspect
    Then the product's info is displayed for the user