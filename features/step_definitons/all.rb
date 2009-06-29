require 'spec/expectations'

When /^I run loris(.*)$/ do |loris_opts|
  run_in_background "#{Loris::RUBY_BINARY} #{Loris::BINARY} #{loris_opts}"
end

Given /^(?:I create )a file named "([^\"]*)"$/ do |file_name|
  @current_dir = working_dir
  create_file(file_name, '')
end
 
Given /^(?:I create )a file named "([^\"]*)" with:$/ do |file_name, file_content|
  @current_dir = working_dir
  create_file(file_name, file_content)
end

When /^I modify the "([^\"]*)" file$/ do |file_name|
  touch_file(file_name)
end

When /^I wait until loris has finished processing changes$/ do
  sleep 0.5
end

Then /^I should see "([^\"]*)" in the Loris output$/ do |text|
  get_background_output.should include text
end

Then /^I should not see any errors$/ do
  get_background_error.strip().should == ""
end
