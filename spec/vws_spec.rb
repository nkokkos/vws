require_relative '../lib/vws.rb'

describe Vws do

  VWS_ACCESSKEY = "your_vws_access_key"
  VWS_SECRETKEY = "your_vws_secret_key"
  

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
    puts "---conn.retrieve_target     04007f1212b24ff79dbe09b1eb693401------- \n"
    response = conn.retrieve_target("04007f1212b24ff79dbe09b1eb693401")
    puts response
  end
  
  describe "delete target" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "---conn.delete_target  43f84a93c3fe444590e55074d95f57d0------- \n"
    response = conn.delete_target("43f84a93c3fe444590e55074d95f57d0")
    puts response
  end
  
   describe "set active to false" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "---set active to false 04007f1212b24ff79dbe09b1eb693401------- \n"
    response = conn.set_active_flag("04007f1212b24ff79dbe09b1eb693401", false)
    puts response
  end
  
end

