require "vws/version"
require 'rubygems'
require 'hmac-sha1'
require 'rest_client'

module Vws
  
  #constants for end point interface links
  BASE_URL		= "https://vws.examplecompany.com/"
  TARGET_URL	= "https://vws.examplecompany.com/targets"
  
  class Api

    def initialize(key=nil, secret=nil)
      @key     = key || ENV['VWS_KEY']
      @secret  = key || ENV['VWS_SECRET']
    end

	def build_signature(request, secret_key)
      contentType = "";
	  hexDigest = "d41d8cd98f00b204e9800998ecf8427e" # Hex digest of an empty string	  
	  
	  if request == "GET" || request == "DELETE" 
	    #Do nothing
	  elsif request == "POST" || request === "PUT" 
	    contentType = "application/json";
		#the request should have a request body
		hexDigest = createMD5Hash(request);
		else 
		  puts "Invalid content type";
	   end
	   
	  #rawstr = ""
      #hmac  = HMAC::SHA1.new(@secret)	   
	end
	
	def signed_request(url, method)
	
	end
	
    def timestamp
      return Time.now.utc.strftime("%Y%m%d%H%M%S")
    end

  end

end
