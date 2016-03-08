Feature: add product to basket

  Background:
    Given I have a defined UB cookie


  @TEST
  Scenario: add a product to the basket
    When I add the product "http://it.boohoo.com/abbigliamento/nuovo-arrivo/dzz91338" to the basket
    Then the item in the basket should have the seller "asos.com"
    And the item in the basket should have the title "ASOS Coat With Seam Detail In Hairy Wool"
    And the checkout button should be disabled

  @rt_1
  Scenario: add a product to the basket rt1
    When I add the product "http://www.richersounds.com/product/wireless-streaming-accessories/harman-kardon/bta10/harm-bta10" to the basket
    Then the item in the basket should have the seller "richersounds.com"
    And the item in the basket should have the title "HARMAN KARDONBTA10"
    And the checkout button should be disabled

  @rt_1_SCENARIO
  Scenario Outline: add a product to the basket rt1 scenario
    When I add the product "<product_url>" to the basket
    Then the item in the basket should have the seller "<seller>"
    And the item in the basket should have the title "<product_title>"
    And the checkout button should be disabled
    Examples:
      | seller            | product_title                                                         | product_url                                                                                       |
      | erichersounds.com | HARMAN KARDONBTA10                                                    | http://www.richersounds.com/product/wireless-streaming-accessories/harman-kardon/bta10/harm-bta10 |
      | richersounds.com  | SOUNDMAGICE10S                                                        | http://www.richersounds.com/product/all-headphones/soundmagic/e10s/soun-e10s                      |
      | johnlewis.com     | Sonos Playbar Home Cinema Sound Bar With Apple Music                  | http://tidd.ly/e832ce2e                                                                           |
      | johnlewis.com     | Sony MDR-EX650 In-Ear Headphones With Mic/Remote, Brass               | http://tidd.ly/c2974c6e                                                                           |
      | johnlewis.com     | Naim Mu-so Digital Wireless Bluetooth Music System With Apple AirPlay | http://tidd.ly/de9ee8c2                                                                           |
      | johnlewis.com     | Sonos Boost                                                           | http://tidd.ly/1b3c849d                                                                           |
      | johnlewis.com     | Apple IPad Air 2, Apple A8X, IOS9, 9.7", Wi-Fi, 16GB                  | http://tidd.ly/4e35820f                                                                           |
      | johnlewis.com     | Bowers & Wilkins T7 Portable Wireless Bluetooth Speaker               | http://tidd.ly/80edcdeb                                                                           |

  Scenario: complete purchase non outline
    Given I add the product "http://www.mytheresa.com/en-gb/rockrunner-native-couture-printed-leather-and-suede-sneakers-523592.html" to the basket
    And I select all the attributes
    And I enter the address "27-31 Clerkenwell Close"
    And I add the default the payment card
    Then the checkout button should be enabled
    When I complete the purchase
    Then I should be presented with the wait for confirmation from shop message
  # todo two ways of handling the back end check for thetransaction
  # And the back office app should show the transactions as failed bad card
  # And I can see the transaction and failed card emails

  @outline
  Scenario Outline: complete purchase
    Given I add the product "<product_url>" to the basket from the country "<country>"
    And I select all the attributes
    And I enter the address "27-31 Clerkenwell Close"
    And I add the default the payment card
    Then the checkout button should be enabled
    #When I complete the purchase
    #Then I should be presented with the wait for confirmation from shop message
  # todo two ways of handling the back end check for thetransaction
  # And the back office app should show the transactions as failed bad card
  # And I can see the transaction and failed card emails
    Examples:
      | country | product_url                                                                                                                                                                                                                                                           |
      | de      | https://www.zalando.de/only-jeans-slim-fit-dark-blue-denim-on321a08q-953.html                                                                                                                                                                                         |
      | fr      | https://www.zalando.fr/boss-orange-nabrilo-echarpe-bo152g00c-c11.html                                                                                                                                                                                                 |
      | fr      | http://www.asos.fr/ASOS-Poncho-oversize-%C3%A0-manches-en-jersey/18s6ty/?iid=5909899&cid=3159&sh=0&pge=0&pgesize=36&sort=-1&clr=Taupe&totalstyles=6415&gridsize=3&mporgp=L0FTT1MvQVNPUy1PdmVyc2l6ZWQtV292ZW4tUG9uY2hvLVdpdGgtSmVyc2V5LVNsZWV2ZXMvUHJvZC8.             |
      | de      | http://www.asos.de/ASOS-Strickkleid-mit-One-Shoulder-Tr%C3%A4ger-in-Metallic/18ufx9/?iid=5628695&cid=18761&sh=0&pge=0&pgesize=36&sort=-1&clr=Pink&totalstyles=1629&gridsize=3&mporgp=L0FTT1MvQVNPUy1EcmVzcy1pbi1Lbml0LXdpdGgtT25lLVNob3VsZGVyLWluLU1ldGFsbGljL1Byb2Qv |
      | de      | http://de.boohoo.com/ausverkauf/azz40734                                                                                                                                                                                                                              |

  Scenario: test empty basket clean up method
    #Given I add the product "http://www.asos.com/pgeproduct.aspx?iid=5039473&CTARef=Basket+Page&r=2" to the basket
    Given I empty the basket


  Scenario: clean up
    Given I remove all addresses, cards, items from the basket

  @newtest
  Scenario: DEFAULT new item
    Given I add the default product to the basket
    And I select a size
    And I enter the address "27-31 Clerkenwell Close"
    And I add the payment card "4111111111111111"
    When I complete the purchase
    Then I should be presented with the wait for confirmation from shop message
# todo two ways of handling the back end check for thetransaction
# And the back office app should show the transactions as failed bad card
# And I can see the transaction and failed card emails





