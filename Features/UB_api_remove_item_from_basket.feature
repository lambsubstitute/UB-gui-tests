@API @api @API_remove_from_basket
Feature: remove item from the basket via the api


  Scenario: remove item from basket - Farfetch - uk
    Given I have a user token
    And I know the product id for the product "http://www.farfetch.com/uk/shopping/women/marc-jacobs-shearling-coat-item-11247965.aspx?storeid=9970&ffref=lp_pic_3_2_"
    When I request through the api the item is added to the basket
    And I remove the item from the basket
    Then my basket should be empty

  #Scenario: remove item from basket - Farfetch - FR
  #  Given I have a user token
  #  And I know the product id for the product "http://www.farfetch.com/fr/shopping/women/marc-jacobs-shearling-coat-item-11247965.aspx?storeid=9970&ffref=lp_pic_3_2_"
  #  When I request through the api the item is added to the basket
  #  And I remove the item from the basket
  #  Then my basket should be empty

  #Scenario: remove item from basket - Farfetch - DE
  #  Given I have a user token
  #  And I know the product id for the product "http://www.farfetch.com/de/shopping/women/dsquared2--skinny-jeans-item-11052231.aspx?storeid=9274&ffref=lp_pic_7_11"
  #  When I request through the api the item is added to the basket
  #  And I remove the item from the basket
  #  Then my basket should be empty

  Scenario: remove item from basket - BooHoo - de
    Given I have a user token
    And I know the product id for the product "http://de.boohoo.com/ausverkauf/azz40734"
    When I request through the api the item is added to the basket
    And I remove the item from the basket
    Then my basket should be empty

  Scenario: remove item from basket - BooHoo - IT
    Given I have a user token
    And I know the product id for the product "http://it.boohoo.com/calzature/dzz97714?zanpid=2112529763012170752&utm_source=ZanoxIT&utm_medium=affiliates&utm_term=2092734&zanoxprogramid=15645"
    When I request through the api the item is added to the basket
    And I remove the item from the basket
    Then my basket should be empty


  Scenario: remove item from basket - Asos - uk
    Given I have a user token
    And I know the product id for the product "http://www.asos.com/ASOS/ASOS-Muscle-Fit-Ribbed-Jumper/Prod/pgeproduct.aspx?iid=5296136&cid=7617&sh=0&pge=0&pgesize=36&sort=-1&clr=Black+%26+white+twist&totalstyles=1391&gridsize=3"
    When I request through the api the item is added to the basket
    And I remove the item from the basket
    Then my basket should be empty

  Scenario: remove item from basket - Asos - FR
    Given I have a user token
    And I know the product id for the product "http://www.asos.fr/ASOS-Poncho-oversize-%C3%A0-manches-en-jersey/18s6ty/?iid=5909899&cid=3159&sh=0&pge=0&pgesize=36&sort=-1&clr=Taupe&totalstyles=6415&gridsize=3&mporgp=L0FTT1MvQVNPUy1PdmVyc2l6ZWQtV292ZW4tUG9uY2hvLVdpdGgtSmVyc2V5LVNsZWV2ZXMvUHJvZC8."
    When I request through the api the item is added to the basket
    And I remove the item from the basket
    Then my basket should be empty

  Scenario: remove item from basket - Asos - DE
    Given I have a user token
    And I know the product id for the product "http://www.asos.de/ASOS-Rock-aus-Wildleder-in-A-Linie-mit-Knopfleiste-und-rundgezacktem-Saum/17cu7k/?iid=5126300&abi=1&clr=black&CTAref=Complete+the+Look+Thumb&mporgp=L0FTT1MvQVNPUy1TdWVkZS1BLUxpbmUtU2tpcnQtV2l0aC1CdXR0b24tVGhyb3VnaC1BbmQtU2NhbGxvcGVkLUhlbS9Qcm9kLw."
    When I request through the api the item is added to the basket
    And I remove the item from the basket
    Then my basket should be empty

  Scenario: remove item from basket - Zalando - FR
    Given I have a user token
    And I know the product id for the product "https://www.zalando.fr/boss-orange-nabrilo-echarpe-bo152g00c-c11.html"
    When I request through the api the item is added to the basket
    And I remove the item from the basket
    Then my basket should be empty

  Scenario: remove item from basket - Zalando - FR
    Given I have a user token
    And I know the product id for the product "https://www.zalando.fr/boss-orange-nabrilo-echarpe-bo152g00c-c11.html"
    When I request through the api the item is added to the basket
    And I remove the item from the basket
    Then my basket should be empty

  Scenario: remove item from basket - Zalando - DE
    Given I have a user token
    And I know the product id for the product "https://www.zalando.de/only-jeans-slim-fit-dark-blue-denim-on321a08q-953.html"
    When I request through the api the item is added to the basket
    And I remove the item from the basket
    Then my basket should be empty

  Scenario: remove item from basket - Zalando - uk
    Given I have a user token
    And I know the product id for the product "https://www.zalando.co.uk/vsp-winter-coat-stone-anthrazit-ve421p00d-q11.html"
    When I request through the api the item is added to the basket
    And I remove the item from the basket
    Then my basket should be empty




