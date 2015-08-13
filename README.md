# HiveCHI-rwm
The home of Ride With Me, a youth, point-to-point, peer-to-peer, transportation solution.

## To Set Up Your Machine (using [Vagrant](https://www.vagrantup.com/))
---
This Vagrant config was set up using [railsbox](https://railsbox.io/boxes/66312daa6dfc).


###Requirements
You will need VirtualBox, vagrant and ansible to be installed. ansible also requires Python and some Python modules to be installed.

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://www.vagrantup.com/downloads)
* [Ansible](http://docs.ansible.com/ansible/intro_installation.html#installation) (Mac users: `brew install ansible`)

###Setup

`cd /path/to/rails/project/railsbox/development`

`vagrant up`

vagrant will download the base box and provision it with ansible using your configuration (this will take ~15-20 minutes if this is your first time using vagrant).

Note that vagrant may ask for a sudo password. That's required when you're using NFS for folder synchronization.

Once it's done, you'll be able to login into it using `vagrant ssh` command. 
The application is stored in /HiveCHI-rwm directory.

To start the app,

`rails s -b0.0.0.0`

The app can be hit locally on your machine at 192.168.20.50:3000/

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
