require_relative '../lib/vws.rb'

describe Vws do
  describe "should connect to webservice and fail otherwise" do
    conn = Vws::Api.new
	puts conn.inspect
	response = conn.list_targets
	puts response
	end

=begin   	
	describe "should connect to webservice and upload file" do
    conn = Vws::Api.new
	puts conn.inspect
	response = conn.upload_file
	puts response
	end
=end

 	
	describe "should connect to webservice and show summary" do
    conn = Vws::Api.new
	puts conn.inspect
	response = conn.summary
	puts response
	end


end

