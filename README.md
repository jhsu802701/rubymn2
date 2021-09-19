# Ruby Users of Minnesota

[![CI](https://github.com/jhsu802701/rubymn2/actions/workflows/ci.yml/badge.svg)](https://github.com/jhsu802701/rubymn2/actions/workflows/ci.yml)
[![security](https://hakiri.io/github/jhsu802701/rubymn2/main.svg)](https://hakiri.io/github/jhsu802701/rubymn2/main)
[![Maintainability](https://api.codeclimate.com/v1/badges/14e118799467367be0aa/maintainability)](https://codeclimate.com/github/jhsu802701/rubymn2/maintainability)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/d1724f3182ef4b1bae334c2d7153cc90)](https://www.codacy.com/gh/jhsu802701/rubymn2/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=jhsu802701/rubymn2&amp;utm_campaign=Badge_Grade)
[![codecov](https://codecov.io/gh/jhsu802701/rubymn2/branch/main/graph/badge.svg?token=Nf8iU7WWTR)](https://codecov.io/gh/jhsu802701/rubymn2)

Welcome to Ruby Users of Minnesota!

## Where is this app deployed?
https://rubymn2.herokuapp.com/

## Setup

### Prerequisites
Docker should be installed on your local machine

### Procedure
* Use the "git clone" command to download this repository.
* Use the "cd" command to enter the root directory of this repository.
* Enter the command "docker/build".  You will be asked to enter database parameters.  The docker/build script automatically sets up the app, runs the test suite, seeds the database, draws the block diagrams, runs quality checks of this code base, and logs the screen output.
* After the build process is complete, enter the command "docker/server" to start the Rails server.  Once it is set up, you should be able to view this app at http://localhost:3000/.
* Start a second terminal tab for entering additional commands.

### Other Important Scripts
* Enter the command "docker/git_check" before "git add" and "git commit".  This runs the tests, Rubocop, Brakeman, Annotate, and certain other tools.  The docker/git_check script is a sanity check to allow you to make sure to commit quality working code only.
* Enter "docker/nuke" to destroy the Docker image, container, and networks.
* Enter "docker/nukec" to destroy the Docker container but leave the base image in place.
* Enter "docker/sandbox" to run the Rails sandbox.
* Enter "docker/testc" to run the controller tests only.  Enter "docker/testcl" to run the docker/testc script plus RuboCop and Rails Best Practices.
* Enter "docker/testh" to run the helper and mailer tests only.  Enter "docker/testhl" to run the docker/testh script plus RuboCop and Rails Best Practices.
* Enter "docker/testc" to run the controller tests only.  Enter "docker/testcl" to run the docker/testc script plus RuboCop and Rails Best Practices.
* Enter "docker/testm" to run the model tests only.  Enter "docker/testml" to run the docker/testm script plus RuboCop and Rails Best Practices.
