require_relative '../lib/vws.rb'

describe Vws do

  VWS_ACCESSKEY = "your_vws_server_access_key"
  VWS_SECRETKEY = "your_vws_server_secret_key"
 
  
#code below between begin and end was an attempt to read env variables from file
=begin
  describe "should connect to webservice and fail otherwise" do
    YAML.load(File.open('spec/local_env.yml')).each do |key, value|
      ENV[key.to_s] = value
     end if File.exists?('spec/local_env.yml')
       if defined?(ENV['VWS_ACCESSKEY']) && defined?(ENV['VWS_SECRETKEY'])
         conn = Vws::Api.new(ENV['VWS_ACCESSKEY'], ENV['VWS_SECRETKEY'])
         conn.inspect
         #puts conn.list_targets
         else
         puts "ENV['VWS_ACCESSKEY'] && ENV['VWS_SECRETKEY' not defined"
       end
    end
=end 

  describe "should connect to webservice and show summary of the cloud database" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "Summary of the target database: \n"
    response = conn.summary
    puts response
  end

  puts "\n"

  describe "should connect to webservice and list all targets" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "Targets in remote database: \n"
    response = conn.list_targets
    puts response
  end
    
    puts "\n"

  describe "should connect to webservice, upload file and fail if the file name is the same" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "Response after trying to add a file: \n"
    response = conn.add_target("newtargetname", "spec/RGB_24bits.jpg", 150, true)
    puts response
  end
    
   puts "\n"
  
  describe "should retrieve a single target info" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "Info for targetid = ee408e0b9d054a04b0df85e0642494d2 \n"
    response = conn.retrieve_target("ee408e0b9d054a04b0df85e0642494d2")
    puts response
  end
     
    puts "\n"
 
  describe "delete target" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "What happens if try to delete a file with targetid =  ee408e0b9d054a04b0df85e0642494d2 ?: \n"
    response = conn.delete_target("ee408e0b9d054a04b0df85e0642494d2")
    puts response
  end
    
    puts "\n"
   
   describe "set active to false" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "Set target to false for targetid = ee408e0b9d054a04b0df85e0642494d2 \n"
    response = conn.set_active_flag("ee408e0b9d054a04b0df85e0642494d2", false)
    puts response
  end
    
    puts "\n"
   
   describe "should connect to webservice, upload Pitt picture and fail if the file name is the same" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "Add Brat Pitt Picture: \n"
    response = conn.add_target("pitt", "spec/pitt.jpg", 210, true)
    puts response
  end
  
end

