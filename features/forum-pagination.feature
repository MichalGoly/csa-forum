Feature: Forum pagination
   Thread list should be paginated
   Navigation between posts and threads should be user friendly

   Background:
      Given that user "cwl4" with password "secret" has logged in
      And he has created "20" posts titled "foo" followed by a number and the body "bar"

   Scenario: Navigate to the second page
      Given user goes to the forum page
      And he uses the pagination to go to view the next page of posts
      Then the page should be on the page number "2" containing "8" threads

   Scenario: Navigate to the previous page from a thread
      Given user navigates to the second page
      And opens the top thread
      And clicks "Back"
      Then the page should be on the page number "2" containing "8" threads
