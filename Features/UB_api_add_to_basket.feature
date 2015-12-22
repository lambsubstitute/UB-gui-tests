Feature: UB api - add to basket



  Scenario: create basket and add product
    Given I have a user token
    And I know the product id for the product "http://www.farfetch.com/uk/shopping/women/dsquared2--skinny-jeans-item-11052231.aspx?storeid=9274&ffref=lp_pic_7_11_"
    When I request through the api the item is added to the basket
    Then the iem requested should be in the new basket

