# MailChimp_exercise
This exercise navigates to MailChimp's About page, reads the name, title and position of each team member featured on the page, and outputs that data to a .csv file.

## Dependencies
The `selenium-webdriver` ruby gem is required:

```gem install selenium-webdriver```

## Run the test

* Clone this repo

* Open a Terminal window

* `cd` into the `MailChimp_exercise` folder

* Run the following command:
```ruby -r "./about_page_test.rb" -e AboutPageTest.new.run_test```

You should now see a `leadership_team.csv' file in the root folder of the repo that contains the name, position and description for each team member.
