Given("he has created {string} posts titled {string} followed by a number and the body {string}") do |number, title, body|
  visit("/topics")
  number.to_i.times do |i|
    click_link("create-thread")
    fill_in("title", :with => title + i.to_s)
    fill_in("body", :with => body)
    click_button("Submit")
    visit("/topics")
  end
end

Given("he uses the pagination to go to view the next page of posts") do
  within ".digg_pagination" do
    click_link("Next")
  end
end

Then("the page should be on the page number {string} containing {string} threads") do |page_no, threads_no|
  current_url.should == topics_url(page: page_no)
  find("tbody").should have_css("tr", :count => threads_no)
end

Given("user navigates to the second page") do
  steps %Q{
    Given user goes to the forum page
    And he uses the pagination to go to view the next page of posts
  }
end

Given("opens the top thread") do
  within "tbody" do
    click_link("Show", match: :first)
  end
end

Given("clicks {string}") do |btn|
  within "main" do
    click_link(btn)
  end
end
