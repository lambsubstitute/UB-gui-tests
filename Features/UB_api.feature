Feature: api documentation testing

  Scenario: can get a api token
    When I request a api user token with a valid api key
    Then I should receive a valid token


  Scenario: I can initiate crawl on a product and get the results
    Given I have a user token
    When I request pre crawl on the product url "http://www.farfetch.com/uk/shopping/women/dsquared2--skinny-jeans-item-11052231.aspx?storeid=9274&ffref=lp_pic_7_11_"
    Then the currency should have the code "GBP" and the symbol "£"


  Scenario Outline: Correct currency json is returned on api product crawl requests
    Given I have a user token
    When I request pre crawl on the product url "<product_url>"
    Then the currency should have the code "<currency_code>" and the symbol "<currency_symbol>"
    Examples:
      | currency_code | currency_symbol | product_url                                                                                                                                                                                                                                               |
      | GBP           | £               | http://www.farfetch.com/uk/shopping/women/dsquared2--skinny-jeans-item-11052231.aspx?storeid=9274&ffref=lp_pic_7_11_                                                                                                                                      |
      | GBP           | £               | http://www.farfetch.com/uk/shopping/women/marc-jacobs-shearling-coat-item-11247965.aspx?storeid=9970&ffref=lp_pic_3_2_                                                                                                                                    |
      | EUR           | €               | https://www.zalando.de/only-jeans-slim-fit-dark-blue-denim-on321a08q-953.html                                                                                                                                                                             |
      | EUR           | €               | http://www.asos.fr/ASOS-Poncho-oversize-%C3%A0-manches-en-jersey/18s6ty/?iid=5909899&cid=3159&sh=0&pge=0&pgesize=36&sort=-1&clr=Taupe&totalstyles=6415&gridsize=3&mporgp=L0FTT1MvQVNPUy1PdmVyc2l6ZWQtV292ZW4tUG9uY2hvLVdpdGgtSmVyc2V5LVNsZWV2ZXMvUHJvZC8. |



Scenario Outline: the following shops should be supported through the api
  Given I have a user token
  When I request the status of the shop "<shop_url>"
  Then the status should be supported
  Examples:
  |shop_url|
  |http://www.farfetch.com|
  |http://www.asos.de     |
  |http://de.boohoo.com   |
  |http://bbc.com         |

