Given(/^a page (.*)$/) do |page|
  @page=page
end
When(/^a title (.*)$/) do |title|
  @title=title
end
When(/^I visit the page$/) do
  visit @page
end
Then(/^I see the title$/) do
  expect(page.title).to include(@title)
end