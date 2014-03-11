Feature:  User visits website

  As a cucumber test writer
  I want to visit a web site
  So that I can write test to see if the web site is working correctly

  Scenario Outline:
    Given a page <page>
    And a title <title>
    When I visit the page
    Then I see the title

  Examples:
    | page | title  |
    | /    | SimDex |