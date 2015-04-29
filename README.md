[![Build Status](https://travis-ci.org/Dinnr-Makers/Dinnr.svg?branch=master)](https://travis-ci.org/Dinnr-Makers/Dinnr)
[![Code Climate](https://codeclimate.com/github/Dinnr-Makers/Dinnr/badges/gpa.svg)](https://codeclimate.com/github/Dinnr-Makers/Dinnr)
[![Test Coverage](https://codeclimate.com/github/Dinnr-Makers/Dinnr/badges/coverage.svg)](https://codeclimate.com/github/Dinnr-Makers/Dinnr)

Dinnr
======

[Dinnr](https://dinnr.herokuapp.com) was built as a two week final project at Makers Academy. It is a social app for organizing dinner parties, similar to Airbnb.

Installation Requirements
-------

- [Image Magick](http://www.imagemagick.org/script/binary-releases.php) needs to be installed in advance
- Postgresql
- You need to set up the following environment variables in a `.env` file in the root directory:
  <br>```GMAIL_DOMAIN=gmail.com
  GMAIL_USERNAME=dinnr.maker@gmail.com
  GMAIL_PASSWORD=XXXXX_YOUR_PASSWORD_XXX
  FACEBOOK_APP_SECRET=XXX_YOUR_FB_SECRET_XXXX
  AWSSecretKey=XXX_YOUR_AMAZON_WEB_SERVICES_KEY_XXX
  AWSAccessKeyId=XXX_YOUR_AWS_ID_XXXX```
- run ```bundle```
- run ```bower install```
- run ```rake db:create db:migrate```
- run ```rails s```

Testing
------
Dinnr is thoroughly tested with RSpec/Capybara. You can run the tests from the command line with:
<br>```rspec```

#On Windows:
We included a third environment for windows development. To run the server in this environment run ```rails s -e development_windows```. In the other environments photo upload won't work on windows machines. This is because the rmagick gem doesn't work on windows machines. In development_windows environment photos get processed by ImageMagick instead. If it doesn't work properly, please check if the path to ImageMagick in ```config/environments/development_windows``` are correct for your ImageMagick installation:

```Paperclip.options[:command_path] = "C:\\Program\ Files\\ImageMagick-6.9.1-Q16"
  Paperclip.options[:command_path] = "C:\\Program\ Files (x86)\\GnuWin32\\bin"```