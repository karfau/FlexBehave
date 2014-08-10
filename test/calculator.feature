Feature: calculator
  Lorem ipsum dolor sit amet, consetetur sadipscing elitr,
  sed diam nonumy eirmod tempor invidunt ut labore et
  dolore magna aliquyam erat, sed diam voluptua.

  Background:
    Given a self powered calculator

  Scenario: addition
    Given a simple calculator
    When 7 was pressed
    And + was pressed
    And 3 was pressed
    And = was pressed
    Then we got 10

  Scenario Outline: mul
    Given a simple calculator
    When <first> was pressed
    And * was pressed
    And <second> was pressed
    And = was pressed
    But we got <result>

  Examples:
    | first | second | result |
    | 2     | 2      |  4 |
    | 2     | 3      |  6 |
    | 3     | 2      |  6 |
    | 3     | 7      | 21 |



