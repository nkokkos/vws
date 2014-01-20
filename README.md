# Vws

This is a ruby gem to interact with Vuforia web services api. Work is in progress

## Installation from source

Clone this repo onto your hard drive and cd into the root folder

First install bundler gem (if it is not installed) gem by issuing:

    gem install bundler

Install the required gems by vws gem by:

    bundle install

Build the vws gem by:

    rake build

This will build the vws.gem into the pkg folder.

Install the gem from the pkg folder by:

    gem install vws.gem


## Basic Installation using Gemfile: 

Add this line to your rails application's Gemfile:

    gem 'vws'

And then execute:

    $ bundle install



## Usage

Instantiate a connection to the api with:

    connection = Vws::Api.new("your_server_vws_access_key", "your_server_vws_secret_key")



TODO: Write more usage instructions here


## Spec

Run the specs at the root of the folder by issuing:

    rspec spec

Currently, only very basic specs have bee written

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
