require_relative '../lib/vws.rb'

describe Vws do

 #VWS_ACCESSKEY = "your_vws_access_key"
 #VWS_SECRETKEY = "your_vws_secrete_key" 

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


  describe "should connect to webservice, upload file and fail if the file name is the same" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "---conn.add_target------- \n"
    response = conn.add_target("newtargetname", "spec/RGB_24bits.jpg", 150, true)
    puts response
  end

  
   describe "retrieve target" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "---conn.retrieve_target------- \n"
    response = conn.retrieve_target("fdc2cc8f9ebd40dab16a7e1de7e7cc33")
    puts response
  end
  
  describe "should connect to webservice and show summary" do
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
    conn.delete_target("fdc2cc8f9ebd40dab16a7e1de7e7cc33")
  end
 
end

