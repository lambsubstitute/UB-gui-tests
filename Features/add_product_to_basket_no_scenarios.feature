Feature: add product to basket -no scanerios

  Background:
    Given I have a defined UB cookie

  #@rt_1_SCENARIO
  Scenario Outline: add a product to the basket rt1 scenario
    When I add the product "<product_url>" to the basket
    Then the item in the basket should have the seller "<seller>"
    And the item in the basket should have the title "<product_title>"
    And the checkout button should be disabled
    Examples:
      | seller            | product_title                                                         | product_url                                                                                       |
      | richersounds.com | HARMAN KARDONBTA10                                                    | http://www.richersounds.com/product/wireless-streaming-accessories/harman-kardon/bta10/harm-bta10 |
      | richersounds.com  | SOUNDMAGICE10S                                                        | http://www.richersounds.com/product/all-headphones/soundmagic/e10s/soun-e10s                      |
      | johnlewis.com     | Sonos Playbar Home Cinema Sound Bar With Apple Music                  | http://tidd.ly/e832ce2e                                                                           |
      | johnlewis.com     | Sony MDR-EX650 In-Ear Headphones With Mic/Remote, Brass               | http://tidd.ly/c2974c6e                                                                           |
      | johnlewis.com     | Naim Mu-so Digital Wireless Bluetooth Music System With Apple AirPlay | http://tidd.ly/de9ee8c2                                                                           |
      | johnlewis.com     | Sonos Boost                                                           | http://tidd.ly/1b3c849d                                                                           |
      | johnlewis.com     | Apple IPad Air 2, Apple A8X, IOS9, 9.7", Wi-Fi, 16GB                  | http://tidd.ly/4e35820f                                                                           |
      | johnlewis.com     | Bowers & Wilkins T7 Portable Wireless Bluetooth Speaker               | http://tidd.ly/80edcdeb                                                                           |


  @rt_1_SCENARIO
  Scenario: add a product to the basket
    When I add the product "http://www.richersounds.com/product/wireless-streaming-accessories/harman-kardon/bta10/harm-bta10" to the basket
    Then the item in the basket should have the seller "richersounds.com"
    And the item in the basket should have the title "HARMAN KARDONBTA10"
    And the checkout button should be disabled

  @rt_1_SCENARIO
  Scenario: add a product to the basket
    When I add the product "http://www.richersounds.com/product/all-headphones/soundmagic/e10s/soun-e10s" to the basket
    Then the item in the basket should have the seller "richersounds.com"
    And the item in the basket should have the title "SOUNDMAGICE10S"
    And the checkout button should be disabled


  @rt_1_SCENARIO
  Scenario: add a product to the basket test
    When I add the product "http://tidd.ly/e832ce2e" to the basket
    Then the item in the basket should have the seller "johnlewis.com"
    And the item in the basket should have the title "Sonos Playbar Home"
    And the checkout button should be disabled


  #@rt_1_SCENARIO
  Scenario: add a product to the basket
    When I add the product "http://tidd.ly/c2974c6e" to the basket
    Then the item in the basket should have the seller "johnlewis.com"
    And the item in the basket should have the title "Sony MDR-EX650 In-Ear Headphones With Mic/Remote, Brass"
    And the checkout button should be disabled



  @rt_1_SCENARIO
  Scenario: add a product to the basket
    When I add the product "http://tidd.ly/de9ee8c2" to the basket
    Then the item in the basket should have the seller "johnlewis.com"
    And the item in the basket should have the title "Naim Mu-so Digital Wireless Bluetooth Music System With Apple AirPlay"
    And the checkout button should be disabled


  @rt_1_SCENARIO
  Scenario: add a product to the basket
    When I add the product "http://tidd.ly/1b3c849d" to the basket
    Then the item in the basket should have the seller "johnlewis.com"
    And the item in the basket should have the title "Sonos Boost"
    And the checkout button should be disabled


  @rt_1_SCENARIO
  Scenario: add a product to the basket
    When I add the product "http://tidd.ly/4e35820f" to the basket
    Then the item in the basket should have the seller "johnlewis.com"
    And the item in the basket should have the title "Apple IPad Air 2"
    And the checkout button should be disabled



  @rt_1_SCENARIO
  Scenario: add a product to the basket
    When I add the product "http://tidd.ly/80edcdeb" to the basket
    Then the item in the basket should have the seller "johnlewis.com"
    And the item in the basket should have the title "Bowers & Wilkins T7 Portable Wireless Bluetooth Speaker"
    And the checkout button should be disabled