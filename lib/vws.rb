require "vws/version"
require 'rubygems'
require 'hmac-sha1'
require 'rest_client'
require 'digest/md5'
require 'time'
require 'openssl'
require 'base64'

module Vws
  
  #constants for end point interface links
  BASE_URL		= "https://vws.examplecompany.com/"
  TARGET_URL	= "https://vws.examplecompany.com/targets"
  
  class Api

    def initialize(accesskey=nil, secretkey=nil)
      @accesskey = accesskey ||  ENV['VWS_ACCESSKEY']
      @secretkey = secretkey || ENV['VWS_SECRETKEY']
    end

	def build_signature(full_path, request_method, secret_key)
      contentType = "";
	  hexDigest = "d41d8cd98f00b204e9800998ecf8427e" # Hex digest of an empty string	  
	  
	  if request_method == "GET" || request_method == "DELETE" 
	    #Do nothing since we have already set contentType and hexDigest
	  elsif request_method == "POST" || request_method === "PUT" 
	    contentType = "application/json";
		#the request should have a request body
		hexDigest = Digest::MD5.hexdigest(full_path)
		else 
		  puts "Invalid content type";
	   end
	   
	   dateValue = "" #get value from header (implement this later on)
       toDigest  = request_method + "\n" + hexDigest + "\n" + 
				   contentType + "\n" + dateValue + "\n" + full_path

	   signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), @secretkey, toDigest)
 
       signature_toBase64 = Base64.encode64(signature)
 
	end
	
	def signed_request(url, method)
	
	end
	
    def timestamp
	  #Date is the current date per RFC 2616, section 3.3.1, rfc1123-date format, e.g.: Sun, 22 Apr #2012 08:49:37 GMT.
      return Time.now.httpdate
    end

  end

end
