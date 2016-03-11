# Campaign Portal

A basic implementation of a campaign portal which allows the user to convert a tarball containing rows of voting data formatted as follows

```
VOTE 1168041980 Campaign:ssss_uk_01B Validity:during Choice:Tupele CONN:MIG00VU MSISDN:00777778429999 GUID:A12F2CF1-FDD4-46D4-A582-AD58BAA05E19 Shortcode:63334
```

into a database which is accessed by a rails application.

## How I approached this task

I first approached this task from the standpoint of developing a small ruby script (later converted into a rake task) which could take in the tarball of data and convert it into database tables representing the campaign, the choices for that campaign and then the votes made for those choices.

The first thing to do was consider a basic loop in psuedocode that might iterate through a file and save objects.

```ruby
File.open(file_path).each do |line|
  vote_line = #the line data in a usable form
  if vote_line.valid?
    vote_line.save
  end
end
```

Following this it became apparent I would want a ruby class which held the state of the current line was able to start work on the VoteLine class (found within `lib/tasks/import_votes_utils.rb`) to provide me with the `valid?` and `save` methods which would be required. This was carried out in a test driven manner to ensure the behavior was as expected at each stage and to provide myself guidance on the design of the class.

As part of this process I also had to come to a decision on how to structure the associations between my database tables. I decided to go with a campaign having many choices, each of which would have many votes cast for them because it would provide a format that was easy to interrogate and minimised the responsibilities of each table.

Following the completion of the script I knew that I was able to succesfully populate the database and as such it was time to start on the application to display the results. Again I approached this task in a test driven manner by starting with a capybara feature spec which would invoke the rake task with test data then verify the content was as expected. Once custom methods were required on my models they had unit tests written to verify they worked as expected.

## Future Improvements

* The UI is very basic right now - just a simple display of the information styled with bootstrap, it could do with some improvements
* The rake task could give some usable feedback to a log file
* Some of the validations could be offloaded from the VoteLine class to the Vote, Campaign and Choice models

## Installation Instructions

You will require ruby installed to use this application.

Clone from github and move into directory

```
$ git@github.com:michaellennox/campaign_portal.git
$ cd campaign_portal
```

Install all dependencies, set up the database and carry out migrations. If you dont have the bundler gem installed you will have to install it with `gem install bundle`

```
$ bundle install
$ rake db:create
$ rake db:migrate
```

## Usage Instructions

To populate your database you will require a tarball with SMS voting data, an example is given in this repo of one `votes.txt` in the root.

To build your database with information from the tarball run the following rake task

```
$ rake import_votes:from_txt file_path=[path to file]
```

Where path to file is the relative path to your file from the current directory. For example to use the included `votes.txt` while in the project root.

```
$ rake import_votes:from_txt file_path=votes.txt
```

You can start the server with rails

```
$ rails s
```

And then can view the data in your database at `localhost:3000`.

## Running Tests

To run the test suite simply run the following command while in the root directory.

```
$ rspec
```
