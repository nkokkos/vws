require_relative '../lib/vws.rb'

describe Vws do

  VWS_ACCESSKEY = "" 
  VWS_SECRETKEY = ""  

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

  
   describe "should retrieve target info" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "---conn.retrieve_target------- \n"
    response = conn.retrieve_target("9ac535f4eb5c454396845791aab13659")
    puts response
  end
  
  describe "should connect to webservice and show summary of the cloud database" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "---conn.summary------- \n"
    response = conn.summary
    parsed = JSON.parse(response)
    puts parsed
    puts "Result:" + parsed["result_code"]   
  end
  
    describe "delete target" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "---conn.delete_target------- \n"
    puts conn.delete_target("9ac535f4eb5c454396845791aab13659")
  end
 
end

