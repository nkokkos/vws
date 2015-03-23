require_relative '../lib/vws.rb'

describe Vws do

  VWS_ACCESSKEY = "your_access_key"
  VWS_SECRETKEY = "your_secret_key"
  
  TARGET_ID_TO_DELETE = "a_target_id_to_delete"
  TARGET_ID_TO_GET_INFO_ON = "a_target_to_get_info_on"
  TARGET_ID_TO_SET_TO_FALSE = "a_target_id_to_set_to_false"

  describe "should connect to webservice and show summary of the cloud database" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "Summary of the target database: \n"
    response = conn.summary
    puts JSON.pretty_generate(JSON.parse(response))
  end

  puts "\n"

  describe "should connect to webservice and list all targets" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "Targets in remote database: \n"
    response = conn.list_targets
    puts JSON.pretty_generate(JSON.parse(response))
  end
    
    puts "\n"

  describe "should connect to webservice, upload file and fail if the file name is the same" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "Response after trying to add a file: \n"
    response = conn.add_target("newtargetname", "spec/RGB_24bits.jpg", 150, true,nil)
    puts JSON.pretty_generate(JSON.parse(response))
  end
    
   puts "\n"
  
  describe "should retrieve a single target info" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "Retrieve Info for targetid = #{TARGET_ID_TO_GET_INFO_ON}"
    response = conn.retrieve_target("test")
    puts JSON.pretty_generate(JSON.parse(response))
  end
  
    puts "\n"
   
  describe "delete target" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "Deleting target id #{TARGET_ID_TO_DELETE}" 
    response = conn.delete_target(TARGET_ID_TO_DELETE)
    puts JSON.pretty_generate(JSON.parse(response))
  end
    
    puts "\n"
   
   describe "set active to false" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "Set target to false for targetid #{TARGET_ID_TO_SET_TO_FALSE}"
    response = conn.set_active_flag(TARGET_ID_TO_SET_TO_FALSE, false)
    puts JSON.pretty_generate(JSON.parse(response))
  end
    
    puts "\n"
   
   describe "should connect to webservice, upload Pitt picture and fail if the file name is the same" do
    conn = Vws::Api.new(VWS_ACCESSKEY, VWS_SECRETKEY)
    puts "Add Brat Pitt Picture: \n"
    response = conn.add_target("pitt", "spec/pitt.jpg", 210, true, nil)
    puts JSON.pretty_generate(JSON.parse(response))
  end
  
end

