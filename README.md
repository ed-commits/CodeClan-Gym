# CodeClan-Gym

# Setting up

To set up the sql database

```
createdb codeclan-gym
psql -d codeclan-gym -f ./db/schema.sql
```

You can rerun the psql command to reset the database too.

# Inspecting the database

Use

```
psql -d codeclan-gym
```

to poke around at the database itself using SQL commands.

# Launching the web app

Make sure you have the necessary gems installed

```
gem install sinatra sinatra-contrib pry
```

then launch the web application with

```
ruby app.rb
```

and point a browser to `localhost:4567`.
