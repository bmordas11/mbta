# mbta
### A simple website to track the MBTA Commuter Rail


# Information about the application

* Ruby version
    - ruby version: 2.2.3

* Database creation
    - Postgres database with ActiveRecord assist for SQL commands
    - Running "rake db:create" will create the database locally

* Database initialization
    - Running "rake db:migrate" will run the database migrations
    - The "rake db:seed" function will run the web-scrape

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)
    - Displays the inbound arrival time of a specific MBTA train

* Deployment instructions
    - WEBrick local server host ("rails s", http://localhost:3000/)
    - Heroku live site
        (git push heroku master, http://mbta-tracker.herokuapp.com/)

--------------------
