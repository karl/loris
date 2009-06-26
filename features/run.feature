Feature: Run Loris

	Scenario: Creating a file triggers loris
		Given I run loris
		When I create a file named "example.txt"
		And I wait until loris has finished processing changes
		Then I should see "example.txt altered!" in the Loris output 
		And I should not see any errors