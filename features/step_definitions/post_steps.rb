Given("that user {string} with password {string} has logged in") do |user, password|
  visit("/session/new")
  fill_in("Login", :with => user)
  fill_in("Password", :with => password)
  click_button("Logon")
end

When("the user creates a new anonymous thread with the title {string} with the body {string}") do |title, body|
  visit("/topics")
  click_link("create-thread")
  fill_in("title", :with => title)
  fill_in("body", :with => body)
  check("anonymous")
  click_button("Submit")
  visit("/topics")
end

Then("the current page should contain a new row containing the data:") do |table|
  # https://gist.github.com/greis/1711522
  table_element = find('table#topics-table')
  headers = table_element.all('thead th').map(&:text)
  # remove Date and the empty header on the very right
  headers.delete_at(5)
  headers.delete_at(0)
  results = table_element.all('tbody tr').map do |tr|
    {}.tap do |hash|
      tds = tr.all('td').map(&:text)
      # remove the timestamp, show and destroy links
      tds.delete_at(6)
      tds.delete_at(5)
      tds.delete_at(0)
      headers.each_with_index do |header, i|
        hash[header] = tds[i]
      end
    end
  end
  table.diff!(results)
end

And("a different user {string} with password {string} logs in") do |username, password|
  visit("session/new")
  fill_in("Login", :with => username)
  fill_in("Password", :with => password)
  click_button("Logon")
end

When("the user replies to the first post with the default title and the body {string}") do |body|
  topics = Topic.all
  visit("/topics/#{topics[0].id}")
  within ".card-action" do
    click_on "Reply"
  end
  fill_in("body", :with => body)
  click_button("Submit")
end

Then("the current thread page should include {string} posts with the 2nd indented by an offset of {string} and author {string}") do |number, offset, author|
  main_element = find('main')
  c = main_element.all("div.card").count
  expect(c).to eq(number.to_i)
  page.should have_css("div.offset-s#{offset}")
  page.should have_text(author)
end
