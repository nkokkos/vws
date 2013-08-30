require "vws/version"
require 'rubygems'
require 'hmac-sha1'
require 'rest_client'
require 'digest/md5'
require 'time'

module Vws
  
  #constants for end point interface links
  BASE_URL		= "https://vws.examplecompany.com/"
  TARGET_URL	= "https://vws.examplecompany.com/targets"
  
  class Api

    def initialize(key=nil, secret=nil)
      @key     = key || ENV['VWS_KEY']
      @secret  = key || ENV['VWS_SECRET']
    end

	def build_signature(full_path, request, secret_key)
      contentType = "";
	  hexDigest = "d41d8cd98f00b204e9800998ecf8427e" # Hex digest of an empty string	  
	  
	  if request == "GET" || request == "DELETE" 
	    #Do nothing
	  elsif request == "POST" || request === "PUT" 
	    contentType = "application/json";
		#the request should have a request body
		hexDigest = Digest::MD5.hexdigest(full_path)
		else 
		  puts "Invalid content type";
	   end
	   
	  #rawstr = ""
      #hmac  = HMAC::SHA1.new(@secret)	   
	end
	
	def signed_request(url, method)
	
	end
	
    def timestamp
	  #Date is the current date per RFC 2616, section 3.3.1, rfc1123-date format, e.g.: Sun, 22 Apr #2012 08:49:37 GMT.
      return Time.now.httpdate
    end

  end

end
