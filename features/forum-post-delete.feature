Feature: Forum post delete
   As a logged in user
   I want to be able to delete my own posts or any post if I'm an admin

   Background:
      Given that user "cwl4" with password "secret" has logged in
      And a new thread titled "How can I add cucumber tests?" with body "Please help!" is created
      And an anonymous thread titled "Deployment to Heroku" with body "How much does it cost?" is created

   Scenario: Author can delete his post
      Given user goes to the forum page
      Then he should be able to delete his thread titled "How can I add cucumber tests?"
      And he should not be able to delete the thread titled "Deployment to Heroku"

   Scenario: User cannot delete posts he has not created
      Given that user "cwl5" with password "secret" has logged in
      And user goes to the forum page
      Then he should not be able to delete the thread titled "How can I add cucumber tests?"
      And he should not be able to delete the thread titled "Deployment to Heroku"

   Scenario: Admin can delete everything
      Given that user "admin" with password "taliesin" has logged in
      And user goes to the forum page
      Then he should be able to delete all threads
