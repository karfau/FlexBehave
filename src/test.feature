
Feature: Seriesplayer

  Scenario: show TEST.AT1
    Given the exercise TEST.AT1
    When we start the practice
    Then we view input

  Scenario: show TEST.AT1
    Given the exercise TEST.AT2
    When we start the practice
    Then we view input

  Scenario: show TEST.AT1
    Given a simple calculator
    When 7 was pressed
    When + was pressed
    When 3 was pressed
    When result was pressed
    Then we got 10