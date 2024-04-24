Feature: Create products
  Users should be able to create a product and add it to the stock when the create product button is
  tapped and the product info is inserted.

  Scenario Outline: Add a product
    Given I'm in any tab
    When I tap the "+" button in the bottom-right of the screen
    And I insert the product <name>
    And I insert the product <quantity>
    And I insert the product <threshold> lower than the quantity
    And I tap "Create Product"
    Then the product gets added to the stock

    Examples:
      | name    | quantity | threshold |
      | "Rice"  | 10       | 4         |
      | "Pasta" | 5        | 2         |
      | "Beans" | 12       | 6         |