# Vws (Vuforia Web Services ruby gem for API access)

This is a ruby gem to interact with Vuforia web services api for managing the targets:
https://developer.vuforia.com/resources/dev-guide/managing-targets-cloud-database-using-developer-api

It uses the excellent rest-client (https://github.com/rest-client/rest-client) to handle the
HTTP/REST requests required by the Vuforia Web Services API.

## Installation from source:


Clone this repo onto your hard drive and cd into the root folder.


First install bundler gem (if it is not installed) by issuing:

    gem install bundler

Install the required gems by vws gem by:

    bundle install

Build the vws gem by:

    rake build

This will build the vws.gem into the pkg folder.


Install the gem from the pkg folder by:

    gem install vws.gem


## Basic Installation using rails Gemfile: 


Add this line to your rails application's Gemfile:

    gem 'vws'

And then execute:

    bundle install


The gem has been uploaded to rubygems.org, therefore you can simply issue:

    gem install vws 
    
and you'll be set.


## Usage

Instantiate a connection to the api with:

    connection = Vws::Api.new("your_server_vws_access_key", "your_server_vws_secret_key")

After a successful connection, you should have access to the vuforia api as shown here:
https://developer.vuforia.com/resources/dev-guide/managing-targets-cloud-database-using-developer-api

So, if you want to get a summary of the cloud database, you issue:

     connection.summary

For a list of targets in your database:

     connection.list_targets

To retrieve a target's info:
     
     connection.retrieve_target(target_id)

To activate or deactivate a target:
    
     connection.set_active_flag(target_id, active_flag) where active_flag = true/false

To add a target to the database:

    connection.add_target(target_name, file_path, width, active_flag)

To delete a target:
    
    connection.delete_target(target_id)

but before deleting a target, you have to set to inactive if it active and
wait for a while:

Change a target flag to inactive/active:
    
    connection.set_active_flag(target_id, active_flag), where active_flag=true/false


## Spec

Enter your server keys into vws_spec.rb file and run the specs at the root 
of the folder by issuing:

    rspec spec

## To do:

  Implement some of the new vws apis and write better documentation :-)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
