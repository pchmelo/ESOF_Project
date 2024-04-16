Feature: Edit products
  Users should be able to edit a product from the stock when the edit button is tapped in the
  product info tab.

  Scenario Outline: Edit a product's name
    Given I'm in the stock tab
    When I tap the product I want to edit
    And I tap the three dots button in the top-right corner
    And I tap "Edit"
    And I insert the product's new <name>
    And I tap "Confirm"
    Then the product's name is edited

    Examples:
      | name      |
      | Banana    |
      | Pineapple |

  Scenario Outline: Edit a product's quantity
    Given I'm in the stock tab
    When I tap the product I want to edit
    And I tap the three dots button in the top-right corner
    And I tap "Edit"
    And I insert the product's new <quantity>
    And I tap "Confirm"
    Then the product's quantity is edited

    Examples:
      | quantity |
      | 10       |
      | 20       |

  Scenario Outline: Edit a product's threshold
    Given I'm in the stock tab
    When I tap the product I want to edit
    And I tap the three dots button in the top-right corner
    And I tap "Edit"
    And I insert the product's new <threshold> lower than the quantity
    And I tap "Confirm"
    Then the product's threshold is edited

    Examples:
      | threshold |
      | 5         |
      | 10        |