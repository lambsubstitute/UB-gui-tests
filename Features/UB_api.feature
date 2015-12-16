Feature: api documentation testing

  Scenario: can get a api token
    When I request a api user token with a valid api key
    Then I should receive a valid token


  Scenario: I can initiate crawl on a product and get the results
    Given I have a user token
    When I request pre crawl on the product url ""
    Then I should receive the data:
    ||
    ||
    ||
    ||