require "vws/version"
require 'rubygems'
require 'rest_client'
require 'digest/md5'
require 'time'
require 'openssl'
require 'base64'

module Vws
  #constants for end point interface links
  BASE_URL = "https://vws.vuforia.com"
  TARGETS_URL = BASE_URL + "/targets"
  class Api
  
    def initialize(accesskey=nil, secretkey=nil)
      @accesskey = "accesskey"   ||  ENV['VWS_ACCESSKEY']
      @secretkey = "secretkey"   ||  ENV['VWS_SECRETKEY']
    end

    def build_signature(request_path, http_verb, timestamp)
      contentType = ""
      hexDigest = "d41d8cd98f00b204e9800998ecf8427e" # Hex digest of an empty string  

      if http_verb == "GET" || http_verb == "DELETE" 
        #Do nothing since we have already set contentType and hexDigest
      elsif http_verb == "POST" || http_verb === "PUT" 
        contentType = "application/json";
        #the request should have a request body
        hexDigest = Digest::MD5.hexdigest(request_path)
      else 
        puts "Invalid request method";
        return nil
      end

      toDigest  = http_verb + "\n" + hexDigest + "\n" + contentType + "\n" + timestamp + "\n" + request_path
      return Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::SHA1.new, @secretkey, toDigest))  
    end

    # Calls the api end point for the list of targets associated with access key and database
    def list_targets
      #Date is the current date per RFC 2616, section 3.3.1, rfc1123-date format, e.g.: Sun, 22 Apr #2012 08:49:37 GMT.
      date_timestamp = Time.now.httpdate # ruby provides this date format with httpdata method
      authorization_header = "VWS " + @accesskey + ":" +  self.build_signature('/targets', 'GET', date_timestamp)
      puts authorization_header
      begin
        RestClient.get(TARGETS_URL, :'Date' => date_timestamp, :'Authorization' => authorization_header)
      rescue => e
        e.response
      end
    end

  end
  
end