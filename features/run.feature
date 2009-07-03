Feature: Run Loris

	Scenario: Creating a file triggers loris
		Given I run loris
		When I create a file named "created.txt"
		And I wait until loris has finished processing changes
		Then I should see "created.txt' modified!" in the Loris output 
		And I should not see any errors
	
	Scenario: Modifying a file triggers loris
		Given I create a file named "modified.txt"
		When I run loris
		And I modify the "modified.txt" file
		And I wait until loris has finished processing changes
		Then I should see "modified.txt' modified!" in the Loris output 
		And I should not see any errors

	Scenario: Modified only triggered once
		Given I create a file named "modified.txt"
		When I run loris
		And I start recording the Loris output
		And I modify the "modified.txt" file
		And I wait until loris has finished processing changes
		And I wait until loris has finished processing changes
		Then I should only see "modified.txt' modified!" once in the recorded output 
		And I should not see any errors
		
	Scenario: Directories not included
		Given I run loris
		When I create a directory named "dir"
		And I wait until loris has finished processing changes
		Then I should NOT see "dir' modified!" in the Loris output
		And I should not see any errors
			
				
				