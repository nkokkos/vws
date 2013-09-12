require_relative '../lib/vws.rb'

describe Vws do

  describe "should connect to webservice and fail otherwise" do
    YAML.load(File.open('spec/local_env.yml')).each do |key, value|
      ENV[key.to_s] = value
     end if File.exists?('spec/local_env.yml')
       if defined?(ENV['VWS_ACCESSKEY']) && defined?(ENV['VWS_SECRETKEY'])
         conn = Vws::Api.new(ENV['VWS_ACCESSKEY'], ENV['VWS_SECRETKEY'])
         conn.inspect
         puts conn.list_targets
         else
         puts "ENV['VWS_ACCESSKEY']  && ENV['VWS_SECRETKEY' not defined"
       end
    end

=begin

  describe "should connect to webservice, upload file and fail if the file name is the same" do
    conn = Vws::Api.new
    #puts conn.inspect
     puts "---conn.upload_file------- \n"
    response = conn.upload_file
    puts response
  end


  describe "should connect to webservice and show summary" do
    conn = Vws::Api.new
    #puts conn.inspect
	puts "---conn.summary------- \n"
    response = conn.summary
    puts response + "\n"
  end
  
=end
 
end

