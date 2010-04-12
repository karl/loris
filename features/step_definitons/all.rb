require 'spec/expectations'

When /^I run loris(.*)$/ do |loris_opts|
  run_in_background "#{Loris::RUBY_BINARY} #{Loris::BINARY} #{loris_opts}"
end

Given /^(?:I create )a file named "([^\"]*)"$/ do |file_name|
  @current_dir = working_dir
  create_file(file_name, '')
end
 
Given /^(?:I create )a directory named "([^\"]*)"$/ do |dir_name|
  @current_dir = working_dir
  create_dir(dir_name)
end
 
Given /^(?:I create )a file named "([^\"]*)" with:$/ do |file_name, file_content|
  @current_dir = working_dir
  create_file(file_name, file_content)
end

When /^I modify the "([^\"]*)" file$/ do |file_name|
  @current_dir = working_dir
  touch_file(file_name)
end

When /^I wait until loris has finished processing changes$/ do
  len = get_background_output.length
  new_output = ""
  while not new_output =~ /\[Poll complete\]/
    new_output = get_background_output[len..-1]
    sleep 0.5
  end
end

When /^I start recording the Loris output$/ do
  @pre_recorded_length = get_background_output.length
end

Then /^I should see "([^\"]*)" in the recorded output$/ do |text|
  recorded = get_background_output[@pre_recorded_length..-1]
  recorded.should include text
end

Then /^I should only see "([^\"]*)" once in the recorded output$/ do |text|
  recorded = get_background_output[@pre_recorded_length..-1]
  recorded.should include text
  recorded.scan(text).length.should equal 1
end

Then /^I should see "([^\"]*)" in the Loris output$/ do |text|
  get_background_output.should include text
end

Then /^the Loris output should contain:$/ do |text|
  get_background_output.should include text
end

Then /^the Loris output should NOT contain:$/ do |text|
  get_background_output.should_not include text
end

Then /^I should NOT see "([^\"]*)" in the Loris output$/ do |text|
  get_background_output.should_not include text
end

Then /^I should not see any errors$/ do
  get_background_error.strip.should == ""
end
