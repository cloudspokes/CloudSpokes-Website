Given /^I am on the home page$/ do
  visit "/"
end

Given /^I am on the member detail page$/ do
  visit "/members\/\S+"
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content text
end

Then /^I should see image "([^"]*)"$/ do |image|
  page.should have_xpath("//img[@src=\"/assets/#{image}\"]")
end

When /^I click "([^"]*)"$/ do |element|
  click_on element
end