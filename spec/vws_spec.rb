require_relative '../lib/vws.rb'

describe Vws do
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
    conn = Vws::Api.new("nosuchaccesskey", "nosuchaccesskey")
    puts "---conn.upload_file------- \n"
    response = conn.add_target("MyNewTargetName", "RGB_24bits.jpg", 150, true)
    puts response
  end

  
   describe "retrieve target" do
    conn = Vws::Api.new("nosuchaccesskey", "nosuchaccesskey")
    puts "---conn.retrieve_target------- \n"
    response = conn.retrieve_target("target_id_goes_here")
    puts response
  end
  
  describe "should connect to webservice and show summary" do
    conn = Vws::Api.new("nosuchaccesskey", "nosuchsecretkey")
    puts "---conn.summary------- \n"
    response = conn.summary
    parsed = JSON.parse(response)
    puts parsed
    puts "Result:" + parsed["result_code"]   
  end
 
end

