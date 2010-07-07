Feature: Run Loris

	Scenario: Creating a file triggers loris
		Given I run loris --debug
		When I create a file named "created.txt"
		And I wait until loris has finished processing changes
		Then I should see "created.txt" in the Loris output 
		And I should not see any errors
	
	Scenario: Modifying a file triggers loris
		Given I create a file named "modified.txt"
		When I run loris --debug
		And I wait until loris has finished processing changes
		And I start recording the Loris output
		And I modify the "modified.txt" file
		And I wait until loris has finished processing changes
		Then I should see "modified.txt" in the recorded output 
		And I should not see any errors
	
	Scenario: Modified only triggered once
		Given I create a file named "modified.txt"
		When I run loris --debug
		And I wait until loris has finished processing changes
		And I start recording the Loris output
		And I modify the "modified.txt" file
		And I wait until loris has finished processing changes
		And I wait until loris has finished processing changes
		Then I should only see "modified.txt" once in the recorded output 
		And I should not see any errors

	Scenario: Directories not included
		Given I run loris --debug
		When I create a directory named "dir"
		And I wait until loris has finished processing changes
		Then I should NOT see "dir" in the Loris output
		And I should not see any errors