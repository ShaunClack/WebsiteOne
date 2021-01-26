# Setting Up for Development on WebSiteOne _(Project Set Up)_

These are the steps for setting up your development environment for WebSiteOne (WSO) project.
This covers the tools you need to have installed and any specific configuration(s).


### Step 1: Git ready (`git` and GitHub)
We use git for version control and keep the project repository on GitHub.
You'll need to be able to use both of those.

* Register on [Github](http://github.com)  (it's free)
* Install [git](https://git-scm.com/)

### Step 2: Get your own local copy of the project to work on
You'll do your development work on your own copy of the project.

[Additional Notes for installation on: [c9](https://github.com/AgileVentures/WebsiteOne/tree/develop/docs/c9), [ubuntu](https://github.com/AgileVentures/WebsiteOne/tree/develop/docs/ubuntu), [osx](https://github.com/AgileVentures/WebsiteOne/tree/develop/docs/osx) ]

* On GitHub, fork [AgileVentures/WebSiteOne](https://help.github.com/articles/fork-a-repo/) into your own GitHub area. 
* Clone your fork to your local development machine (or where-ever you are going to do your development coding).
  To clone the fork, run the following command on your local machine:
    
    `git clone https://github.com/<your-github-name>/WebsiteOne`

If you need more information about git and GitHub, see this [general guide to getting set up with an AgileVentures project](http://www.agileventures.org/articles/project-setup-new-users) (use https://github.com/AgileVentures/WebsiteOne as the project URL).

You should now have the entire project -- all of the directories and files -- on your local machine, _and_ it should have a `git` repository (`.git`).

When you've finished working on you changes, create a pull request (PR) on GitHub. Here are [detailed insttructions on how to create a pull request for WSO](how_to_submit_a_pull_request_on_github.md).

The whole process of doing a PR and getting it reviewed and merged into this project is described in [CONTRIBUTING.md](../CONTRIBUTING.md).

#### Keeping a fork up to date
1. Clone your fork:
```
git clone git@github.com:YOUR-USERNAME/YOUR-FORKED-REPO.git
```

2. Add remote from original repository in your forked repository:
```
cd into/cloned/fork-repo
git remote add upstream https://github.com/AgileVentures/WebsiteOne.git
git fetch upstream
```
3. Updating your fork from original repo to keep up with [WebsiteOne](https://github.com/AgileVentures/WebsiteOne):
```
git pull upstream develop
```

### Step 3: There are two options of setting up, choose one.

## Option 1 - Installation and Usage with Docker
See the [Docker Project Setup](../docker/README.md) documentation

## Option 2 - Local Installation

### Step 1 of Local Install: Install the gems with `bundle install`

    bundle install

**Note:** On OSX El Capitan and above, you may get this error:

    An error occurred while installing eventmachine (1.0.7), and Bundler cannot continue.
    Make sure that `gem install eventmachine -v '1.0.7'` succeeds before bundling.

If you then try to install the `eventmachine` gem, it also fails like this: https://github.com/eventmachine/eventmachine/issues/643.
 That's because OpenSSL is no longer distributed with OS X. So you may need to use brew to set up OpenSSL:

    brew link openssl --force

After you do that, re-try running `bundle install` and you should be good to go on to the next step.

**Note:** If you get this error:
Your Ruby version is 2.7.0, but your Gemfile specified 2.6.3

Check if you have Ruby 2.6.3
    `rvm list`

If you have 2.6.3, type:
    `rvm use 2.6.3`
If you do not have 2.6.3, type:
    `rvm install 2.6.3`

### Step 2 of Local Install: PostgreSQL and the `pg` gem
The database used is [postgreSQL](https://www.postgresql.org/).  You need to have this installed and running on your local machine. 
[Here are instructions on installing postgreSQL.](development_environment_set_up.md#postgreSQL)

(Info only: the `pg` gem accesses the postgreSQL database.)

### Step 3 of Local Install: Install javascript dependencies using `npm`
* Use [npm](https://www.npmjs.com/) to install all of the javascript dependencies for WSO: 

    `npm install`

* Use [npm](https://www.npmjs.com/) to ensure [bower](https://bower.io/) is installed:

    `npm install bower`

### Step 4 of Local Install: Phantomjs
[Phantomjs](http://phantomjs.org/) is used to run tests.  [Here are detailed instructions for installing it.](development_environment_set_up.md#phantomjs)

### Step 5 of Local Install: Request the .env file and confirm your locale
    
* You'll have to get the `.env` file from one of the admins: @tansaku or @diraulo.  The project won't work without it.  You can send them a direct message (DM) on Slack.  The `.env` file should go in the root of the WSO project.
* It should look something like:

```
RECAPTCHA_SITE_KEY=6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI
RECAPTCHA_SECRET_KEY=6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe
SECRET_KEY_BASE=blabla

You may also need:

RACK_TIMEOUT_SERVICE_TIMEOUT=200000000
STRIPE_SECRET_KEY=xxxx
STRIPE_PUBLISHABLE_KEY=xxxx
AIRBRAKE_API_KEY=blahblahblah
AIRBRAKE_PROJECT_ID=123

```

the above are test keys from https://developers.google.com/recaptcha/docs/faq

    

### Step 4: Set up the database

* Run the rake command to set up the database.  Be sure to use `bundle exec` so that the gems specific to this project (listed in the Gemfile) are used:

    `bundle exec rake db:setup`
    
### Step 5: Run the tests

Now you're ready to run the tests:

    bundle exec rake spec
    bundle exec rake jasmine:ci
    bundle exec rake cucumber

Discuss any errors with the team on Slack, in a scrum, or in mob or pair programming.

### Step 6. Start the server

    bundle exec rails s
    
You can now see the system working on your local development environment!
    
Be sure to read and understand [how to contribute](../CONTRIBUTING.md) when you're ready to start developing and contributing.
 




## Code Style

We recommend and follow the [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide)

[Here are notes about comments and altering other's code.](code_style_conventions.md)




[Note: This page originally at https://github.com/AgileVentures/WebsiteOne/wiki/Project-Setup-%28New-Users%29]

# Appendix

## Updating Rails
If you need to update rails, you can run `bundle update rails`.  If you run into problems with rails and `libv8` on OS X, try this:
```shell
   gem uninstall libv8
   brew install v8
   gem install therubyracer
   gem install libv8 -v '3.16.14.3' -- --with-system-v8
```
  

