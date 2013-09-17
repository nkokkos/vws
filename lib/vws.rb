require "vws/version"
require 'rubygems'
require 'rest_client'
require 'digest/md5'
require 'time'
require 'openssl'
require 'base64'
require 'json'
require 'yaml'

module Vws
  #constants for end point interface links
   BASE_URL = "https://vws.vuforia.com"
   TARGETS_URL = BASE_URL + "/targets"
   SUMMARY_URL = BASE_URL + "/summary"
   #TARGETS_URL = "http://requestb.in/118jky11" # simple end point 
                                                # for get/post checks
  class Api
  
    def initialize(accesskey=nil, secretkey=nil)
      @accesskey = accesskey || ENV['VWS_ACCESSKEY']
      @secretkey = secretkey || ENV['VWS_SECRETKEY']
    end

    def build_signature(request_path, body_hash, http_verb, timestamp)
      #request path signifies the suburi called minus the BASE_URL; that is,
      # if you call https://vws/vuforia.com/targets, the request_path="/targets"
      
      contentType = ""
      hexDigest = "d41d8cd98f00b204e9800998ecf8427e" # Hex digest of an empty 
                                                     # string. We use it to 
                                                     # signify empty body

      if http_verb == "GET" || http_verb == "DELETE" 
        #Do nothing since we have already set contentType and hexDigest
      elsif http_verb == "POST" || http_verb == "PUT" 
        contentType = "application/json";
        #the request should have a request body, so create an md5 hash of that
        #json data
        hexDigest = Digest::MD5.hexdigest(body_hash.to_json)
      else 
        puts "Invalid request method";
        return nil
      end
      
      toDigest  = http_verb   +   "\n" + 
                  hexDigest   +   "\n" + 
                  contentType +   "\n" + 
                  timestamp   +   "\n" + 
                  request_path

      return Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::SHA1.new, 
                              @secretkey, toDigest))  
    end

    # Calls the api end point for the list of targets associated with 
    # access key and database
    def list_targets
      #Date is the current date per RFC 2616, section 3.3.1, 
      #rfc1123-date format, e.g.: Sun, 22 Apr #2012 08:49:37 GMT.
      date_timestamp = Time.now.httpdate #ruby provides this date format 
                                         #with httpdate method
      signature = self.build_signature('/targets', nil, 'GET', date_timestamp)
      authorization_header = "VWS " + @accesskey + ":" +  signature
      begin
        RestClient.get(TARGETS_URL, :'Date' => date_timestamp, 
                                    :'Authorization' => authorization_header)
      rescue => e
        e.response
      end
    end

    def add_target(target_name, file_path, width, active_flag)
      date_timestamp = Time.now.httpdate 
      #for file uploads, read file contents data and Base 64 encode it.
      contents_encoded = Base64.encode64(File.open(file_path, 'rb').read)
      body_hash = { :name => target_name, 
                    :width => width, #widths should be in scene units 
                    :image => contents_encoded, 
                    :active_flag => active_flag }
      signature = self.build_signature('/targets', body_hash, 'POST', date_timestamp)
      authorization_header = "VWS " + @accesskey + ":" +  signature
      begin
        RestClient.post(TARGETS_URL, body_hash.to_json, 
                                    :'Date' => date_timestamp, 
                                    :'Authorization' => authorization_header, 
                                    :content_type => 'application/json', 
                                    :accept => :json)
      rescue => e
        e.response
      end
    end

    def summary
      date_timestamp = Time.now.httpdate
      signature = self.build_signature('/summary', nil, 'GET', date_timestamp) 
      authorization_header = "VWS " + @accesskey + ":" + signature
      begin
        RestClient.get(SUMMARY_URL, :'Date' => date_timestamp, 
                                    :'Authorization' => authorization_header)
      rescue => e
        e.response
      end
    end
    
    def retrieve_target(target_id)
      date_timestamp = Time.now.httpdate
      target_id_url = TARGETS_URL + '/' + target_id
      target_id_suburl = '/targets' + '/' + target_id
      signature = self.build_signature(target_id_suburl, nil, 'GET', date_timestamp)
      authorization_header = "VWS " + @accesskey + ":" + signature
      begin
        RestClient.get(target_id_url, :'Date' => date_timestamp,
                                      :'Authorization' => authorization_header)
      rescue => e
        e.response
      end
    end

    def delete_target(target_id)
      #In order to delete the target, we have to set it to non-active.
      #First we post a PUT/POST action to the target url and update the target's 
      #active_flag to false. Then we post a delete action to delete the
      #target
      date_timestamp = Time.now.httpdate
      target_id_url = TARGETS_URL + '/' + target_id
      target_id_suburl = '/targets' + '/' + target_id
      body_hash = {:active_flag => 0}
      signature = self.build_signature(target_id_suburl, body_hash, 'PUT', date_timestamp)
      authorization_header = "VWS " + @accesskey + ":" + signature
      
      begin
        response = RestClient.post(target_id_url, body_hash.to_json, 
                                      :'Date' => date_timestamp, 
                                      :'Authorization' => authorization_header, 
                                      :content_type => 'application/json', 
                                      :accept => :json))
        json_response = JSON.parse(response)
        if json_response["result_code"] == "Success"
          #call api again to delete target, implement this later on
        end
        rescue => e
          e.response
      end
    end

  
  end
end
