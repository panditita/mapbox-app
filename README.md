# MapBox App

This project is being developed to learn to use mapbox with rails. It consists of two maps, a simple loading version of Mexico City and a custom one that will display Mexico's states along with their abbreviation and total population.

## Technologies 

* Ruby version 2.6.3

* Rails version 6.0.1 

* Haml version 5.1.2

* Foundation Rails version 6.5.3

* PostgreSQL version 11.5

## Setup

To run this project:

* Git clone to download it locally
* Check your ruby version using `ruby -v`, if upgrade needed use `brew upgrade ruby`
* Install Rails using `gem install rails`
* On your project directory run to install all the dependencies needed:
    1 -  `gem install bundler`
    2 - `bundle install`
    3 - `yarn install --check-files`
* Recreate the database `rails db:setup db:create db:migrate`
* Finally `rails server` to run it in your localhost

*Please note that you'll need to create an account with mapbox to generate a token and use it in the application
