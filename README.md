# Gem is archived. If you want to continue, you are welcome to do so

# Vws (Vuforia Web Services ruby gem for API access for target management)

This is a ruby gem to interact with Vuforia web services api for managing the targets:
https://developer.vuforia.com/library//articles/Solution/How-To-Use-the-Vuforia-Web-Services-API

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


The gem has been uploaded to rubygems.org (http://rubygems.org/gems/vws), therefore you can simply issue:

    gem install vws 
    
and you'll be set.


## Usage:

Instantiate a connection to the api with:

    connection = Vws::Api.new("your_server_vws_access_key", "your_server_vws_secret_key")

After a successful connection, you should have access to the vuforia api as shown here:
https://developer.vuforia.com/library/articles/Solution/How-To-Use-the-Vuforia-Web-Services-API

So, if you want to get a summary of the cloud database, you issue:

    connection.summary

For a list of targets in your database:

     connection.list_targets

To retrieve a target's info:
     
     connection.retrieve_target(target_id)

To activate or deactivate a target:
    
     connection.set_active_flag(target_id, active_flag) where active_flag = true/false

To add a target to the database:

    connection.add_target(target_name, file_path, width, active_flag, application_metadata)
You may set application_metadata = nil if you do not use this attribute

To delete a target:
    
    connection.delete_target(target_id)

but before deleting a target, you have to set to inactive if it active and
wait for a while:

Change a target flag to inactive/active:
    
    connection.set_active_flag(target_id, active_flag), where active_flag=true/false

List duplicates for target:

    connection.list_duplicates(target_id)
    

## Parsing the output:

Response from the server is in JSON(text/string) format. So, you can easily parse the output and convert it to a Hash with keys. For example you may parse the output as such:

    connection_hash = JSON.parse(connection)
    
Once you do that, you have access to the list of the hash's keys with
    
    connection_hash.keys
    
Then, you can grab the information relating to a certain key with:

    connection_hash["key"]

For example, here you can find the keys from the response after asking for the database summary:
https://developer.vuforia.com/library/articles/Solution/How-To-Get-a-Database-Summary-Report-Using-the-VWS-API. 
From that you can extract the name of the database with:

    connection_hash["name"]


## Attributes of the uploaded file:
Vuforia has a great article about what makes a target ideal:
https://developer.vuforia.com/library/articles/Best_Practices/Attributes-of-an-Ideal-Image-Target
Currently, this ruby gem does not check for file size or any other attributes addressed in the article above.


## Spec

Enter your server keys into vws_spec.rb file and run the specs at the root 
of the folder by issuing:

    rspec spec


##Caveats

Setting a target from on to off and vice versa takes some time. It may take up to
0-10 minutes and it's based on Vuforia's infrastucture. It is your responsibilty 
to poll for the changes on the target since no such feature has been implemented
in this gem. More you can find here: https://developer.vuforia.com/library//articles/Best_Practices/Best-Practices-for-using-the-VWS-API


##Special thanks to 

Everyone who has mentioned errors in the codes and especially to 
https://github.com/c0m3tx and https://github.com/jlitola for the PRs. 


## Contributing

Please, if you use it, report back any bugs/problems.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

This software is licensed under the MIT License (MIT).

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
