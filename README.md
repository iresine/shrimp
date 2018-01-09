Shrimp
======

Trivia questions application running on localhost.  
After choosing if provided statement is true or false, shrimp decides if answer is correct.


Prerequests
-----------
Ruby: ruby-2.3.3  
Ruby on Rails: 5.1.4  
Node.js  

System: Linux, Mac OS


Instructions for Linux
-----------------------------
These instructions will get you a copy of the project up and running on your local machine for testing and development purposes.

```
# install prerequests
---
# instal nodejs
sudo apt-get install nodejs

# fetch mpapis public key 
gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
# or if it fails:
command curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -

# instal latest stable rails version which will also pull in the associated latest stable release of Ruby with rvm
cd /tmp
curl -sSL https://get.rvm.io -o rvm.sh
cat /tmp/rvm.sh | bash -s stable --rails
---

# clone repository
git clone https://github.com/iresine/shrimp
cd shrimp/

# source the rvm scripts from the directory they were installed, which will typically be in your home/username directory
source ~/.rvm/scripts/rvm

# install ruby
rvm install ruby-2.3.3

# install dependencies
gem install bundler
bundle install

# run application
bin/rails s
```

Open url in webbrowser:
```
http://localhost:3000/shrimp
```

How it works
------------
```
* go to shrimp homepage in webbrowser (http://localhost:3000/shrimp)
result: page with statement is rendered

* click on the correct answer to the statement (TRUE or FALSE)
* to see correct answer for testing purposes right beside the qestion, uncomment line 17 in app/views/questions/show.html/haml file
result: page with text 'CORRECT ANSWER' and loving shrimp image is rendered

* click on 'random question' link
result: shrimp homepage is rendered with question from random category

* click on the wrong answer
result: page with text 'WRONG ANSWER' and angry shrimp image is rendered

* click on the first link on the page - 'another question from category: ...'
result: shrimp homepage with question from the same category as previous questions category is rendered
```

How to run tests
----------------
```
bundle exec rspec
```

Gratitude
---------
Special thanks to Magdalena Glanowska for sharing shrimp image
