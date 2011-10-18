Feature: CloudSpoke Website
    Basic steps for the "Challenge" function

    Scenario: View home page
        Given I am on the home page
        Then I should see "Join Us"

    Scenario: Visit challenge index page
        Given I am on the home page
        When I click "Challenges"
        Then I should see "List of Challenges"
