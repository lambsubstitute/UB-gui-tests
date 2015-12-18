Feature: api documentation testing

  Scenario: can get a api token
    When I request a api user token with a valid api key
    Then I should receive a valid token


  Scenario: I can initiate crawl on a product and get the results
    Given I have a user token
    When I request pre crawl on the product url "http://www.farfetch.com/uk/shopping/women/dsquared2--skinny-jeans-item-11052231.aspx?storeid=9274&ffref=lp_pic_7_11_"
    Then the currency should have the code "GBP" and the symbol "£"


  Scenario Outline: I can initiate crawl on a product and get the results
    Given I have a user token
    When I request pre crawl on the product url "<product_url>"
    Then the currency should have the code "<currency_code>" and the symbol "<currency_symbol>"
    Examples:
      | currency_code | currency_symbol | product_url                                                                                                            |
      | GBP           | £               | http://www.farfetch.com/uk/shopping/women/dsquared2--skinny-jeans-item-11052231.aspx?storeid=9274&ffref=lp_pic_7_11_   |
      | GBP           | £               | http://www.farfetch.com/uk/shopping/women/marc-jacobs-shearling-coat-item-11247965.aspx?storeid=9970&ffref=lp_pic_3_2_ |
      | EUR           | €               | https://www.zalando.de/only-jeans-slim-fit-dark-blue-denim-on321a08q-953.html                                          |


