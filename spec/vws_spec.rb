require_relative '../lib/vws.rb'

describe Vws do

  VWS_ACCESSKEY = "VWS_ACCESSKEY" 
  VWS_SECRETKEY = "VWS_SECRETKEY" 

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


  describe "should connect to webservice, list_targets" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "---conn.list_targets------- \n"
    response = conn.list_targets
    puts response
  end

  describe "should connect to webservice, upload file and fail if the file name is the same" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "---conn.add_target------- \n"
    response = conn.add_target("newtargetname", "spec/RGB_24bits.jpg", 150, true)
    puts response
  end
  
    describe "should connect to webservice, upload file and fail if the file name is the same" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "---conn.add_target------- \n"
    response = conn.add_target("newtargetname5", "spec/RGB_24bits.jpg", 150, true)
    puts response
  end
    
  describe "should connect to webservice and show summary of the cloud database" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "---conn.summary------- \n"
    response = conn.summary
    puts response
  end
  
  describe "should retrieve target info" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "---conn.retrieve_target     903cdcdd8d4c4c32a7c027d2d151b57b------- \n"
    response = conn.retrieve_target("903cdcdd8d4c4c32a7c027d2d151b57b")
    puts response
  end
  
  describe "delete target" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "---conn.delete_target  721151f5bdf044dc9aefb0a33c3d6560------- \n"
    response = conn.delete_target("903cdcdd8d4c4c32a7c027d2d151b57b")
    puts response
  end
  
end

