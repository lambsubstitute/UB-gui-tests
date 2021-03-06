Feature: adding products from international stores

@asos_currency_bug
  Scenario Outline: can add an international product to the basket
    When I add the product "<product_url>" to the basket from the country "<country>"
    Then I should see the basket
    And it should have an item in it
    And the item currency should match the "<currency>"
    And the basket subtotals should have the currency "<currency>"
    Examples:
      | currency | country | product_url                                                                                                                                                                                                                                                           |
      #| £        | uk      | http://www.farfetch.com/uk/shopping/women/marc-jacobs-shearling-coat-item-11247965.aspx?storeid=9970&ffref=lp_pic_3_2_                                                                                                                                                |
      #| €        | it      | http://it.boohoo.com/abbigliamento/nuovo-arrivo/dzz91338                                                                                                                     |
      #| €        | de      | https://www.zalando.de/only-jeans-slim-fit-dark-blue-denim-on321a08q-953.html                                                                                                                                                                                         |
      | €        | de      | http://www.asos.de/ASOS-Rock-aus-Wildleder-in-A-Linie-mit-Knopfleiste-und-rundgezacktem-Saum/17cu7k/?iid=5126300&abi=1&clr=black&CTAref=Complete+the+Look+Thumb&mporgp=L0FTT1MvQVNPUy1TdWVkZS1BLUxpbmUtU2tpcnQtV2l0aC1CdXR0b24tVGhyb3VnaC1BbmQtU2NhbGxvcGVkLUhlbS9Qcm9kLw. |
      | €        | de      | http://www.asos.de/ASOS-Strickkleid-mit-One-Shoulder-Tr%C3%A4ger-in-Metallic/18ufx9/?iid=5628695&cid=18761&sh=0&pge=0&pgesize=36&sort=-1&clr=Pink&totalstyles=1629&gridsize=3&mporgp=L0FTT1MvQVNPUy1EcmVzcy1pbi1Lbml0LXdpdGgtT25lLVNob3VsZGVyLWluLU1ldGFsbGljL1Byb2Qv |
      #| €        | de      | http://de.boohoo.com/ausverkauf/azz40734                                                                                                                                                                                                                              |
      #| €        | fr      | https://www.zalando.fr/bally-veste-en-cuir-black-23b22j004-q11.html                                                                                                                                                                                                |
      | €        | fr      | http://www.asos.fr/Brixton-Westward-Panama/190mgx/?iid=5860954&cid=6517&Rf-800=116,-1&sh=0&pge=0&pgesize=36&sort=-1&clr=Brown&totalstyles=3&gridsize=3&mporgp=L0JyaXh0b24vQnJpeHRvbi1XZXN0d2FyZC1GZWRvcmEvUHJvZC8.             |
      | €        | it      | http://www.asos.it/ASOS/ASOS-Muscle-Fit-Ribbed-Jumper/Prod/pgeproduct.aspx?iid=5296136&cid=7617&sh=0&pge=0&pgesize=36&sort=-1&clr=Black+%26+white+twist&totalstyles=1391&gridsize=3                                                                                  |
      #| £        | uk      | http://www.farfetch.com/uk/shopping/women/dsquared2--skinny-jeans-item-11052231.aspx?storeid=9274&ffref=lp_pic_7_11_                                                                                                                                                  |


  Scenario: should not be able to add products from different territories
    Given I have a german product in the basket
    When i try to add a uk product
    Then the item should not be added to the basket
