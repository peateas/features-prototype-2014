Given(/^this cucumber directory$/) do
  step("a cucumber directory 'features'")
end

Given(/^a cucumber directory '(.*)'$/) do |directory|
  Dir.should exist(directory)
  @cucumber = CucumberHelper.new(directory, logger('cucumber_helper'))
  @cucumber.should_not be_nil
end

When(/^the system checks names$/) do
  @cucumber.verify_names
end

Then(/^all the names match the file names$/) do
  unmatched = @cucumber.unmatched
  unmatched.should be_empty, "found #{unmatched.count} unmatched features"
end

Given(/^this scenario for a high level feature$/) do
end

Given(/^the (.*?) wants to start "(.*?)"$/) do |user, feature|
  verify_feature(feature)
end

Given(/^the (.*?) is starting "([^"]*)"$/) do |user, feature|
  verify_feature(feature)
end

When(/^the (.*?) does "(.*?)"$/) do |user, feature|
  verify_feature(feature)
end

Then(/^this scenario is successful$/) do
end


Then(/^unimplemented scenario "([^"]*)"$/) do |scenario|
  logger('feature').warn { "Scenario '#{scenario}' unimplemented" }
  false.should be_true, "unimplemented scenario: #{scenario}"
end
