Given("a new thread titled {string} with body {string} is created") do |title, body|
  visit("/topics")
  click_link("create-thread")
  fill_in("title", :with => title)
  fill_in("body", :with => body)
  click_button("Submit")
end

Given("an anonymous thread titled {string} with body {string} is created") do |title, body|
  visit("/topics")
  click_link("create-thread")
  fill_in("title", :with => title)
  fill_in("body", :with => body)
  check("anonymous")
  click_button("Submit")
end

Given("user goes to the forum page") do
  visit("/topics")
end

Then("he should be able to delete his thread titled {string}") do |title|
  within find('tr', text: title) do
    click_on "Destroy"
  end
end

Then("he should not be able to delete the thread titled {string}") do |title|
  within('tr', :text => title) do
    page.should_not have_link('Destroy')
  end
end

Then("he should be able to delete all threads") do
  find("tbody").should have_css("a", :count => 4)
  within "tbody" do
    click_link("Destroy", match: :first)
  end
  find("tbody").should have_css("a", :count => 2)
  within "tbody" do
    click_link("Destroy", match: :first)
  end
  find("tbody").should_not have_css("a")
end
