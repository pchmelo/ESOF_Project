Feature: Add an image to a product
  Users should be able to upload an image to a product from the stock when the change icon from camera
  or the change icon from gallery buttons are pressed.

  Scenario: Upload an image from the camera
    Given I'm in the product's info screen
    When I tap the change icon from camera button
    Then the camera is opened
    When I take a picture
    Then the picture is displayed as that product's icon

Scenario: Upload an image from the gallery
    Given I'm in the product's info screen
    When I tap the change icon from gallery button
    Then the gallery is opened
    When I select a picture
    Then the picture is displayed as that product's icon