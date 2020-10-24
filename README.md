l# Planter's Digest
Planter's Digest is a Ruby on Rails Web Application that allows the user to not only stay accountable by tracking the progress of their house plants, but also leave tips/comments to all other users's plants.

* Ruby version
2.6.1


# Prerequisites
Bundle init to Bundle the following Ruby Gems:

ruby '2.6.1'

* Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
<li>gem 'rails', '~> 6.0.3', '>= 6.0.3.4'</li>
* Use sqlite3 as the database for Active Record
<li>gem 'sqlite3', '~> 1.4'</li>
<li># Use Puma as the app server
<li>gem 'puma', '~> 4.1'</li>
# Use SCSS for stylesheets
<li>gem 'sass-rails', '>= 6'</li>
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
<li>gem 'webpacker', '~> 4.0'</li>
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
<li>gem 'turbolinks', '~> 5'</li>
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
<li>gem 'jbuilder', '~> 2.7'</li>
# Use Redis adapter to run Action Cable in production
<li># gem 'redis', '~> 4.0'</li>
# Use Active Model has_secure_password
<li>gem 'bcrypt', '~> 3.1.7'</li>

* Use Active Storage variant
 <li>gem 'image_processing', '~> 1.2'</li>

* Reduces boot times through caching; required in config/boot.rb
<li>gem 'bootsnap', '>= 1.4.2', require: false</li>

<li>group :development, :test do</li>
  * Call 'byebug' anywhere in the code to stop execution and get a debugger console
  <li>gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]</li>
end

group :development do
  * Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  <li>gem 'web-console', '>= 3.3.0'</li>
  <li>gem 'listen', '~> 3.2'</li>
  * Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  <li>gem 'spring'</li>
  <li>gem 'spring-watcher-listen', '~> 2.0.0'</li>
end

group :test do
  * Adds support for Capybara system testing and selenium driver
  <li>gem 'capybara', '>= 2.15'</li>
  <li>gem 'selenium-webdriver'</li>
  * Easy installation and use of web drivers to run system tests with browsers
  <li>gem 'webdrivers'</li>
end

* Windows does not include zoneinfo files, so bundle the tzinfo-data gem
<li>gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]</li>

<li>gem "pry", "~> 0.13.1"</li>

<li>gem "faker", "~> 2.14"</li>

<li>gem "omniauth", "~> 1.9"</li>

<li>gem "dotenv-rails", "~> 2.7"</li>

<li>gem "omniauth-google-oauth2", "~> 0.8.0"</li>



* Deployment instructions

# Installation
<li>
Travel to https://github.com/ParishBen/plant_diary_digest to clone the repo. 
Reach out to ParishBen13@gmail.com for Session Secrete variable.
Bundle Install the above gem list.
Execute shotgun to rackup project to your browser on your localhost.
Signup & go!
</li>

# Contributing Guidelines
<p> Thanks for taking the time to contribute!<br>
The following is a short set of guideline to contribute to Plant Diary Digest.<br></p>
<li>
First and foremost get the Ruby Environment installed.  Then you'll need to follow the instructions above Installation instruction. 
</li>
<li>Feel free to reach out at any point to ParishBen13@gmail.com regarding any issues</li>
<li>Pull Requests are welcome! Please ensure to leave a detailed PR description of the problem & solution.</li>

# Built With
<li>
Ruby on Rails
</li>

# Author
<li> Benjamin Parish</li>

# License

This project is licensed under the MIT License - see the LICENSE.md file for details

