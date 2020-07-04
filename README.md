# SPEEK README

Speek is a social platform built with Ruby on Rails. 

Speek allows users to create a profile, write posts/blog in markdown syntax, reply to posts, follow friends, and create communities to interact with others.

Things you may want to cover:

## Install 
Clone this repository.

Enter the application directory: `cd /speek`

Install the required gems: `bundle install`

Configure the /config/database.yml file with your postgresdb name and password.

Run `rake db:schema:load`

Modify the /db/seeds.rb file to create your admin account. Then run `rake db:seed`.

Boot the server with `rails s` and dig in!

## Screenshots
Profile view.
![](https://i.ibb.co/VttDgV9/image.png)

Dashboard/Activity feed.
![](https://i.ibb.co/PDKX5Sj/image.png)