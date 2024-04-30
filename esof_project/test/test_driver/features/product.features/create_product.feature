Feature: Create products
  Users should be able to create a product and add it to the stock when the create product button is
  tapped and the product info is inserted.

  Scenario Outline: Create a product
    Given I'm in the stock tab
    When I tap the "+" button in the bottom-right of the screen
    And I insert the product <name>
    And I insert the product <threshold>
    And I tap "Create Product"
    And I tap the "+" int the middle of the footer
    And I tap the "+" that appears in the middle of the screen
    And I select the product I created
    And I insert a <quantity> to add to the product
    Then the product gets added to the stock with that quantity

    Examples:
      |  name   | threshold | quantity |
      | "Rice"  | 4         | 5        |
      | "Pasta" | 2         | 3        |
      | "Beans" | 6         | 7        |

  Scenario Outline: Create a product with expiration date
    Given I'm in the stock tab
    When I tap the "+" button in the bottom-right of the screen
    And I insert the product <name>
    And I insert the product <threshold>
    And I check the "Expires" checkbox
    And I tap "Create Product"
    And I tap the "+" int the middle of the footer
    And I tap the "+" that appears in the middle of the screen
    And I select the product I created
    And I insert a <quantity> to add to the product
    And I insert a <name_of_subproduct> to the product
    And I select an expiration date
    And I tap "Confirm"
    Then the product gets added to the stock with that quantity and a subproduct with expiration date is created

    Examples:
      |  name   | threshold | quantity | name_of_subproduct |
      | "Carne" | 4         | 5        | "Porco"            |
      | "Peixe" | 2         | 3        | "Bacalhau"         |