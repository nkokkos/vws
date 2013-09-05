require_relative '../lib/vws.rb'

describe Vws do
  describe "should connect to webservice and fail otherwise" do
    conn = Vws::Api.new
	puts conn.inspect
	response = conn.list_targets
	puts response
	end
end

