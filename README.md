# README

This RSS reader application requires installation of redis to run. It uses sidekiq to update all feeds every minute. 

* Ruby version - 2.5.1

* System dependencies - Redis server

* Database creation - The application uses sqlite3 as a database server. To create the db file run
```
 rails db:create
 rails db:migrate
```

* Running the tests
```
bundle exec rake db:drop RAILS_ENV=test
bundle exec rake db:create RAILS_ENV=test
bundle exec rake db:schema:load RAILS_ENV=test
```

* Services 
Redis server
Sidekiq job scheduler

* Deployment instructions
Clone the repo localy then run
```
bundle exec rake db:create
bundle exec rake db:migrate
```

* Starting the application
To start the application run the start.sh script located in the applicaiton folder.

* Known bugs/issues
-- Issue with submitting the feed creation form. No error message produced, nothing in the JS console of the browser. Fixed by replacing the native sumbit functionality with javascript submit function.
