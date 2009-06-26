Feature: Run Loris

	Scenario: Creating a file triggers loris
		Given I run loris
		When I create a file named "created.txt"
		And I wait until loris has finished processing changes
		Then I should see "created.txt altered!" in the Loris output 
		And I should not see any errors
	
	Scenario: Modifying a file triggers loris
		Given I create a file named "modified.txt"
		When I run loris
		And I modify the "modified.txt" file
		And I wait until loris has finished processing changes
		Then I should see "modified.txt altered!" in the Loris output 
		And I should not see any errors