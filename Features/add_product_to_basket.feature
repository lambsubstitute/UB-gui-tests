Feature: add product to basket

  @TEST
  Scenario: add a product to the basket
    When I add the product "http://www.asos.com/pgeproduct.aspx?iid=5039473&CTARef=Basket+Page&r=2" to the basket
    Then the item in the basket should have the seller "asos.com"
    And the item in the basket should have the title "ASOS Coat With Seam Detail In Hairy Wool"
    And the checkout button should be disabled


    Scenario: complete purchase
      Given I add the product "http://www.asos.com/pgeproduct.aspx?iid=5039473&CTARef=Basket+Page&r=2" to the basket
      And I select a size
      And I enter the telephone number "07568091557"
      And I enter the address "27-31 Clerkenwell Close"
      And I select the address "27 31 Clerkenwell Close"
      And I add the payment card "4111111111111111"
      When I complete the purchase

  Scenario: test empty basket clean up method
    Given I empty the basket


    Scenario: clean up
      Given I remove all addresses, cards, items from the basket




