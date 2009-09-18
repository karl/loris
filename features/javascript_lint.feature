Feature Javascript Lint

	Scenario: Javascript Lint is run
		Given I run loris --debug
		When I create a file named "example.js" with:
"""
var foo = function() {
	x = 'moo'
}
"""
		And I wait until loris has finished processing changes
		Then the Loris output should contain:
"""
Javascript Lint
warning
"""
		And I should not see any errors

# 	Scenario: Javascript Lint is run when Loris starts
# 		When I create a file named "example.js" with:
# """
# var foo = function() {
# 	x = 'moo'
# }
# """
# 		Given I run loris --debug
# 		And I wait until loris has finished processing changes
# 		Then the Loris output should contain:
# """
# Javascript Lint
# warning
# """
# 		And I should not see any errors
# 
