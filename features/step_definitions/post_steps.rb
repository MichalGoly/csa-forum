Given("that user {string} with password {string} has logged in") do |user, password|
  visit("session/new")
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
