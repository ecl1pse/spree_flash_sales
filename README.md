SpreeFlashSales
===============

[![Code Climate](https://codeclimate.com/github/ecl1pse/spree_flash_sales.png)](https://codeclimate.com/github/ecl1pse/spree_flash_sales)
[![Dependency Status](https://gemnasium.com/ecl1pse/spree_flash_sales.png)](https://gemnasium.com/ecl1pse/spree_flash_sales)
[![Coverage Status](https://coveralls.io/repos/ecl1pse/spree_flash_sales/badge.png)](https://coveralls.io/r/ecl1pse/spree_flash_sales)
[![Coverage Status](https://coveralls.io/repos/ecl1pse/spree_flash_sales/badge.png?branch=master)](https://coveralls.io/r/ecl1pse/spree_flash_sales?branch=master)
[![Coverage Status](https://coveralls.io/repos/ecl1pse/spree_flash_sales/badge.png?branch=master)](https://coveralls.io/r/ecl1pse/spree_flash_sales?branch=master)
[![Build Status](https://travis-ci.org/ecl1pse/spree_flash_sales.png?branch=master)](https://travis-ci.org/ecl1pse/spree_flash_sales)

Adds "flash sale" functionality to Spree engine. Tested with Spree 4+. 

Check the specs for how it works.

Installation
------------

Add spree_flash_sales to your Gemfile:

```ruby
gem 'spree_flash_sales'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_flash_sales:install
```

If you don't run the generators make sure you append the following to your js and css files.

Javascript stuff:

```
  append_file 'app/assets/javascripts/store/all.js', "//= require store/spree_flash_sales"
  append_file 'app/assets/javascripts/admin/all.js', "//= require admin/spree_flash_sales"
```

```
  inject_into_file 'app/assets/stylesheets/store/all.css', " *= require store/spree_flash_sales"
  inject_into_file 'app/assets/stylesheets/admin/all.css', " *= require admin/spree_flash_sales"
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_flash_sales/factories'
```

Special Thanks
--------------

https://github.com/suryart/spree_active_sale for inspiration and example code.

Copyright (c) 2013 [ecl1pse], released under the New BSD License
