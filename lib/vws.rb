require "vws/version"
require 'rubygems'
require 'rest_client'
require 'digest/md5'
require 'time'
require 'openssl'
require 'base64'

module Vws
  #constants for end point interface links
  BASE_URL = "http://requestb.in/1bm5ihn1" # use this for testing api. Will remove/replace at the end
  #BASE_URL = "https://vws.examplecompany.com/"
  TARGET_URL = BASE_URL + "targets"
  
  class Api
  
    def initialize(accesskey=nil, secretkey=nil)
      accesskey = accesskey ||  ENV['VWS_ACCESSKEY']
      @secretkey = secretkey || ENV['VWS_SECRETKEY']
	end

    def build_signature(full_path, request_method, timestamp)
      contentType = ""
      hexDigest = "d41d8cd98f00b204e9800998ecf8427e" # Hex digest of an empty string	  
	  
      if request_method == "GET" || request_method == "DELETE" 
	    #Do nothing since we have already set contentType and hexDigest
      elsif request_method == "POST" || request_method === "PUT" 
        contentType = "application/json";
        #the request should have a request body
        hexDigest = Digest::MD5.hexdigest(full_path)
      else 
        puts "Invalid request method";
        return nil
      end

      dateValue = timestamp
      toDigest  = request_method + "\n" + hexDigest + "\n" + 
				   contentType + "\n" + dateValue + "\n" + full_path
	 
      #generate hmac digest with openssl methods	 
      signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), @secretkey, toDigest)
      
      #encode result to base64 
      signature_toBase64 = Base64.encode64(signature)
    
    end
	
    def timestamp
      #Date is the current date per RFC 2616, section 3.3.1, rfc1123-date format, e.g.: Sun, 22 Apr #2012 08:49:37 GMT.
      return Time.now.httpdate
    end
	
    def list_targets
      date_timestamp = self.timestamp
      authorization_header = "Authorization: VWS " + @accesskey + ":" +  self.build_signature(TARGET_URL, 'GET', date_timestamp)
      RestClient.get(BASE_URL, :'Date' => date_timestamp, :'Authorization' => authorization_header, :content_type => :json)
	end
	
  end

end