# HiveCHI-rwm
The home of Ride With Me, a youth, point-to-point, peer-to-peer, transportation solution.

## Contributing:
---

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

=======
## Local Development Setup

----

###Try an IDE in the cloud
We recommend [Cloud 9](https://ide.c9.io/).

When creating a new workspace, copy this url into the "Clone from Git or Mercurial" text box:
git@github.com:MozillaHive/HiveCHI-rwm.git


### Using rbenv

#### Prerequisites

You will need to have [Postgres](http://www.postgresql.org) installed and running.

On OS X, you can just download Postgres.app from http://postgresapp.com and run it.

This guide will assume you are using [rbenv](https://github.com/sstephenson/rbenv#installation) for Ruby. You could use [rvm](https://rvm.io/rvm/install) instead.

To quickly set up rbenv on OS X with [Homebrew](http://brew.sh), first pour with

        brew update && brew install rbenv ruby-install

   Then to your `.bash_profile` add the line

        if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

   and reload your profile

        source ~/.bash_profile


#### Instructions

1. Clone the repository locally, and change to the working directory.

        git clone https://github.com/MozillaHive/HiveCHI-rwm.git
        cd HiveCHI-rwm

2. Install the correct version of Ruby. Using rbenv:

        rbenv install
        rbenv rehash

3. Install [Bundler](http://bundler.io).

        gem install bundler
        rbenv rehash

5. Use Bundler to set up the required gems.

        bundle install
        rbenv rehash

6. Now set up the database (if this doesn't work, there are detailed instructions for configuring Postgres [here](https://ridewithmeapp.slack.com/files/kyaroch/F089ZSBJ7/Configuring_Postgres_on_your_local_machine)).

        rake db:create
        rake db:migrate

7. Seed the database with test data.

        rake db:seed

8. Fill in `config/application.yml`. Twilio test credentials should be available [here](https://ridewithmeapp.slack.com/files/omnignorant/F08V5JH2P/Twilio_Test_Credentials). If you encounter issues with these, set `PHONE_VERIFICATION` to `DISABLED` and you will still be able to register new user accounts.

9. Finally, start the server.

        rails s

10. If everything went right, the application should now be running locally at [http://localhost:3000/](http://localhost:3000/).

###Try using [Vagrant](https://www.vagrantup.com/)
**Note** Vagrant setup is completely optional.  If you are having trouble setting up locally, this may be a valid option.


This Vagrant config was set up using [railsbox](https://railsbox.io/boxes/66312daa6dfc).


####Requirements
You will need VirtualBox, vagrant and ansible to be installed. ansible also requires Python and some Python modules to be installed.

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://www.vagrantup.com/downloads)
* [Ansible](http://docs.ansible.com/ansible/intro_installation.html#installation) (Mac users: `brew install ansible`)

####Setup

`cd /path/to/rails/project/railsbox/development`

`vagrant up`

vagrant will download the base box and provision it with ansible using your configuration (this will take ~15-20 minutes if this is your first time using vagrant).

Note that vagrant may ask for a sudo password. That's required when you're using NFS for folder synchronization.

Once it's done, you'll be able to login into it using `vagrant ssh` command.
The application is stored in /HiveCHI-rwm directory.

To start the app,

`rails s -b0.0.0.0`

The app can be hit locally on your machine at 192.168.20.50:3000/
