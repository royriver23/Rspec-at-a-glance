Feature: Achievement Page

  In order to read other achievements
  As a guess user
  I want to see public achievement

  Scenario: guess user sees public achievement
    Given I am a guess user
    And there is a public achievement
    When I go to the achievement's page
    Then I must achievement's content
