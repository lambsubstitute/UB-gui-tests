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
      | currency_code | currency_symbol | product_url                                                                                                                                                                                                                                                           |
      | GBP           | £               | http://www.farfetch.com/uk/shopping/women/dsquared2--skinny-jeans-item-11052231.aspx?storeid=9274&ffref=lp_pic_7_11_                                                                                                                                                  |
      | GBP           | £               | http://www.farfetch.com/uk/shopping/women/marc-jacobs-shearling-coat-item-11247965.aspx?storeid=9970&ffref=lp_pic_3_2_                                                                                                                                                |
      | EUR           | €               | https://www.zalando.de/only-jeans-slim-fit-dark-blue-denim-on321a08q-953.html                                                                                                                                                                                         |
      | EUR           | €               | http://www.asos.fr/ASOS-Poncho-oversize-%C3%A0-manches-en-jersey/18s6ty/?iid=5909899&cid=3159&sh=0&pge=0&pgesize=36&sort=-1&clr=Taupe&totalstyles=6415&gridsize=3&mporgp=L0FTT1MvQVNPUy1PdmVyc2l6ZWQtV292ZW4tUG9uY2hvLVdpdGgtSmVyc2V5LVNsZWV2ZXMvUHJvZC8.             |
      | GBP           | £               | http://www.farfetch.com/uk/shopping/women/marc-jacobs-shearling-coat-item-11247965.aspx?storeid=9970&ffref=lp_pic_3_2_                                                                                                                                                |
      | EUR           | €               | http://it.boohoo.com/calzature/dzz97714?zanpid=2112529763012170752&utm_source=ZanoxIT&utm_medium=affiliates&utm_term=2092734&zanoxprogramid=15645                                                                                                                     |
      | EUR           | €               | https://www.zalando.de/only-jeans-slim-fit-dark-blue-denim-on321a08q-953.html                                                                                                                                                                                         |
    # | EUR | €             | http://www.asos.de/ASOS-Rock-aus-Wildleder-in-A-Linie-mit-Knopfleiste-und-rundgezacktem-Saum/17cu7k/?iid=5126300&abi=1&clr=black&CTAref=Complete+the+Look+Thumb&mporgp=L0FTT1MvQVNPUy1TdWVkZS1BLUxpbmUtU2tpcnQtV2l0aC1CdXR0b24tVGhyb3VnaC1BbmQtU2NhbGxvcGVkLUhlbS9Qcm9kLw. |
      | EUR           | €               | http://www.asos.de/ASOS-Strickkleid-mit-One-Shoulder-Tr%C3%A4ger-in-Metallic/18ufx9/?iid=5628695&cid=18761&sh=0&pge=0&pgesize=36&sort=-1&clr=Pink&totalstyles=1629&gridsize=3&mporgp=L0FTT1MvQVNPUy1EcmVzcy1pbi1Lbml0LXdpdGgtT25lLVNob3VsZGVyLWluLU1ldGFsbGljL1Byb2Qv |
      | EUR           | €               | http://de.boohoo.com/ausverkauf/azz40734                                                                                                                                                                                                                              |
      | EUR           | €               | https://www.zalando.fr/boss-orange-nabrilo-echarpe-bo152g00c-c11.html                                                                                                                                                                                                 |
      | EUR           | €               | http://www.asos.fr/ASOS-Poncho-oversize-%C3%A0-manches-en-jersey/18s6ty/?iid=5909899&cid=3159&sh=0&pge=0&pgesize=36&sort=-1&clr=Taupe&totalstyles=6415&gridsize=3&mporgp=L0FTT1MvQVNPUy1PdmVyc2l6ZWQtV292ZW4tUG9uY2hvLVdpdGgtSmVyc2V5LVNsZWV2ZXMvUHJvZC8.             |
      | EUR           | €               | http://www.asos.com/ASOS/ASOS-Muscle-Fit-Ribbed-Jumper/Prod/pgeproduct.aspx?iid=5296136&cid=7617&sh=0&pge=0&pgesize=36&sort=-1&clr=Black+%26+white+twist&totalstyles=1391&gridsize=3                                                                                  |
      | GBP           | £               | http://www.farfetch.com/uk/shopping/women/dsquared2--skinny-jeans-item-11052231.aspx?storeid=9274&ffref=lp_pic_7_11_                                                                                                                                                  |


  Scenario Outline: the following shops should be supported through the api
    Given I have a user token
    When I request the status of the shop "<shop_url>"
    Then the status should be supported
    Examples:
      | shop_url                |
      | http://www.farfetch.com |
      | http://www.asos.de      |
      | http://de.boohoo.com    |
      | http://bbc.com          |

