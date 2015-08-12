# HiveCHI-rwm
The home of Ride With Me, a youth, point-to-point, peer-to-peer, transportation solution.


### Contributing:

When you begin working on an issue:

1. make sure nobody else is already working on it;
2. assign the issue to yourself;
2. add the In Progress label;
3. create a new branch and name it with the issue number in front of it (eg. 110-css-work).

If you are no longer working on an issue:

1. immediately remove the In Progress label, so that someone else can work on it;
2. if you have partial changes committed and pushed to the branch, add a comment to the issue explaining what's done and what's still missing.

When you complete your work on the issue:

1. commit and push your branch;
2. create a pull request.

When you merge a pull request:

1. remove the In Progress label;
2. close the issue.


### Setup:

To run the site locally, follow these steps:

1. Clone the repository locally, and change to the working directory.

        git clone https://github.com/MozillaHive/HiveCHI-rwm.git
        cd HiveCHI-rwm

2. Make sure [Ruby](https://www.ruby-lang.org/) and [RubyGems](https://rubygems.org/) are installed. They should be installed automatically on OS X. Typing `gem` at the console should print a help message.

3. Install [Bundler](http://bundler.io). On OS X:

        sudo gem install bundler

3. Install and start [Postgres](http://www.postgresql.org). On OS X, you can use can download Postgres.app from http://postgresapp.com and run it.

4. Install the Ruby Postgres interface. On OS X:

        sudo env ARCHFLAGS="-arch x86_64" gem install pg

5. Run `bundle install`.

6. Set up the database (if this doesn't work, there are detailed instructions for configuring Postgres [here](https://ridewithmeapp.slack.com/files/kyaroch/F089ZSBJ7/Configuring_Postgres_on_your_local_machine)):

        rake db:create
        rake db:migrate

7. Seed the database with test data:

        rake db:seed

8. Fill in `config/application.yml`. Twilio test credentials should be available [here](https://ridewithmeapp.slack.com/files/omnignorant/F08V5JH2P/Twilio_Test_Credentials). If you encounter issues with these, set `PHONE_VERIFICATION` to `DISABLED` and you will still be able to register new user accounts.

9. Now start the server:

        rails s

10. If everything went right, the application should now be running locally at [http://localhost:3000/](http://localhost:3000/).
