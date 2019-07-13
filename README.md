# Brownfield Of Dreams

This is the base repo for a brownfield project used at Turing for Backend Mod 3.

Project Spec and Evaluation Rubric: https://github.com/turingschool-examples/brownfield-of-dreams

### Project Board

Students will continue to build on the existing code base using the cards within the following Github Project: https://github.com/turingschool-examples/brownfield-of-dreams/projects/1

**Learning Goals and Labels**

The cards are labeled in a way that correspond to learning goals or to specific areas you might personally want to focus on.

Cards should be completed from top to bottom in the To Do column. Cards labeled `good first issue` are good as filler work and will allow you to practice common Rails skills.

### About the Project

This is a Ruby on Rails application used to organize YouTube content used for online learning. Each tutorial is a playlist of video segments. Within the application an admin is able to create tags for each tutorial in the database. A visitor or registered user can then filter tutorials based on these tags.

A visitor is able to see all of the content on the application but in order to bookmark a segment they will need to register. Once registered a user can bookmark any of the segments in a tutorial page.

## Local Setup

Clone down the repo
```
$ git clone
```

Install the gem packages
```
$ bundle install
```

Delete `yarn.lock` file

Delete 'BUNDLED WITH' and line below from Gemfile.lock

Install node packages for stimulus
```
$ brew install node
$ brew install yarn
$ yarn add stimulus
```

Run `bundle exec figaro install`
  Populate application.yml with :
  ```
  YOUTUBE_API_KEY: <your youtube api key>
  GITHUB_UID: <your github user id>
  GITHUB_API_KEY: <your github api key>
  GITHUB_CLIENT_ID: <your app's github client id>
  GITHUB_CLIENT_SECRET: <your app's github client secret>
  SENDGRID_API_KEY: <your sendgrid api key>
  ```

Set up the database
```
$ bundle exec rake db:create
$ bundle exec rake db:migrate
$ bundle exec rake db:seed
```

Run the test suite:
```ruby
$ bundle exec rspec
```

## Technologies
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [webpacker](https://github.com/rails/webpacker)
* [vcr](https://github.com/vcr/vcr)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)

### Versions
* Ruby 2.4.1
* Rails 5.2.0
