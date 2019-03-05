require "vws/version"
require 'rubygems'
require 'rest_client'
require 'digest/md5'
require 'time'
require 'openssl'
require 'base64'
require 'json'
require 'open-uri'


module Vws
  #constants for end point interface links
   BASE_URL = "https://vws.vuforia.com"
   TARGETS_URL = BASE_URL + "/targets"
   SUMMARY_URL = BASE_URL + "/summary"
   DUPLICATES_URL = BASE_URL + "/duplicates"

  class Api

    def initialize(accesskey=nil, secretkey=nil)
      @accesskey = accesskey || ENV['VWS_ACCESSKEY']
      @secretkey = secretkey || ENV['VWS_SECRETKEY']
    end

    def build_signature(request_path, body_hash, http_verb, timestamp)
      # request_path signifies the suburi you call after you subtract the
      # BASE_URL; that is, if you call https://vws/vuforia.com/targets,
      # the request_path is '/targets'

      contentType = ""
      hexDigest = "d41d8cd98f00b204e9800998ecf8427e" # Hex digest of an empty
                                                     # string. We use it to
                                                     # signify empty body

      if http_verb == "GET" || http_verb == "DELETE"
        # Do nothing since we have already set contentType and hexDigest
      elsif http_verb == "POST" || http_verb == "PUT"
        contentType = "application/json";
        # the request should have a request body, so create an md5 hash of that
        # json body data
        hexDigest = Digest::MD5.hexdigest(body_hash.to_json)
      else
        puts "Invalid request method for signature method: " + http_verb
        return nil
      end

      toDigest  = http_verb   + "\n" +
                  hexDigest   + "\n" +
                  contentType + "\n" +
                  timestamp   + "\n" +
                  request_path

      return Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::SHA1.new,
                              @secretkey, toDigest))
    end

    # Calls the api end point for the list of targets associated with
    # server access key and cloud database
    # https://developer.vuforia.com/library/articles/Solution/How-To-Get-a-Target-List-for-a-Cloud-Database-Using-the-VWS-API
    def list_targets
      #Date is the current date per RFC 2616, section 3.3.1,
      #rfc1123-date format, e.g.: Sun, 22 Apr #2012 08:49:37 GMT.
      date_timestamp = Time.now.httpdate #ruby provides this date format
                                         #with httpdate method
      signature = self.build_signature('/targets', nil, 'GET', date_timestamp)
      raise ArgumentError.new('Signature returned nil. Aborting...') if signature == nil

      authorization_header = "VWS " + @accesskey + ":" +  signature
      begin
        RestClient.get(TARGETS_URL, :'Date' => date_timestamp,
                                    :'Authorization' => authorization_header)
      rescue => e
        e.response
      end
    end

    def add_target(target_name, file_path, width, active_flag, metadata=nil)
      raise "file path is required"   if file_path.nil?
      raise "target name is required" if target_name.nil?
      date_timestamp = Time.now.httpdate
      #for file uploads, read file contents data and Base 64 encode it:
      contents_encoded = Base64.encode64(open(file_path) { |io| io.read })
      metadata_encoded = Base64.encode64(metadata.to_s)
      body_hash = { :name => target_name,
                    :width => width, #width of the target in scene units
                    :image => contents_encoded,
                    :active_flag => active_flag,
                    :application_metadata => metadata_encoded }
      signature = self.build_signature('/targets', body_hash, 'POST', date_timestamp)
      raise ArgumentError.new('Signature returned nil. Aborting...') if signature == nil
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

    def update_target(target_id, target_name=nil, file_path=nil, width=nil, active_flag=nil, metadata=nil)
      date_timestamp = Time.now.httpdate
      target_id_url = TARGETS_URL + '/' + target_id
      target_id_suburl = '/targets' + '/' + target_id
      #for file uploads, read file contents data and Base 64 encode it:
      contents_encoded = file_path ? Base64.encode64(open(file_path) { |io| io.read }) : nil
      metadata_encoded = metadata ? Base64.encode64(metadata.to_s) : nil

      body_hash = {}.merge( target_name ? { :name => target_name } : {} )
      body_hash = body_hash.merge( width ? { :width => width } : {} )
      body_hash = body_hash.merge( contents_encoded ? { :image => contents_encoded } : {} )
      body_hash = body_hash.merge( !active_flag.nil? ? { :active_flag => active_flag } : {} )
      body_hash = body_hash.merge( metadata_encoded ? { :application_metadata => metadata_encoded } : {} )

      signature = self.build_signature(target_id_suburl, body_hash, 'PUT', date_timestamp)
      raise ArgumentError.new('Signature returned nil. Aborting...') if signature == nil
      authorization_header = "VWS " + @accesskey + ":" +  signature
      begin
        RestClient.put(target_id_url, body_hash.to_json,
                                    :'Date' => date_timestamp,
                                    :'Authorization' => authorization_header,
                                    :content_type => 'application/json',
                                    :accept => :json)
      rescue => e
        e.response
      end
    end

    # Database Summary Report
    # https://developer.vuforia.com/resources/dev-guide/database-summary-report
    def summary
      date_timestamp = Time.now.httpdate
      signature = self.build_signature('/summary', nil, 'GET', date_timestamp)
      raise ArgumentError.new('Signature returned nil. Aborting...') if signature == nil
      authorization_header = "VWS " + @accesskey + ":" + signature
      begin
        RestClient.get(SUMMARY_URL, :'Date' => date_timestamp,
                                    :'Authorization' => authorization_header)
      rescue => e
        e.response
      end
    end

    # Retrieve a target from the cloud database
    # https://developer.vuforia.com/resources/dev-guide/retrieving-target-cloud-database
    def retrieve_target(target_id)
      date_timestamp = Time.now.httpdate
      target_id_url = TARGETS_URL + '/' + target_id
      target_id_suburl = '/targets' + '/' + target_id
      signature = self.build_signature(target_id_suburl, nil, 'GET', date_timestamp)
      raise ArgumentError.new('Signature returned nil. Aborting...') if signature == nil
      authorization_header = "VWS " + @accesskey + ":" + signature
      begin
        RestClient.get(target_id_url, :'Date' => date_timestamp,
                                      :'Authorization' => authorization_header)
      rescue => e
        e.response
      end
    end

    # Target Summary Report
    # https://developer.vuforia.com/resources/dev-guide/target-summary-report
    def target_summary(target_id)
      date_timestamp = Time.now.httpdate
      target_id_url = SUMMARY_URL + '/' + target_id
      target_id_suburl = '/summary' + '/' + target_id
      signature = self.build_signature(target_id_suburl, nil, 'GET', date_timestamp)
      authorization_header = "VWS " + @accesskey + ":" + signature
      begin
        RestClient.get(target_id_url, :'Date' => date_timestamp,
                                      :'Authorization' => authorization_header)
      rescue => e
        e.response
      end
    end

    def set_active_flag(target_id, active_flag)
      date_timestamp = Time.now.httpdate
      target_id_url = TARGETS_URL + '/' + target_id
      target_id_suburl = '/targets' + '/' + target_id
      body_hash = {:active_flag => active_flag}
      signature = self.build_signature(target_id_suburl, body_hash, 'PUT', date_timestamp)
      raise ArgumentError.new('Signature returned nil. Aborting...') if signature == nil
      authorization_header = "VWS " + @accesskey + ":" + signature
      begin
        RestClient.put(target_id_url, body_hash.to_json,
                                      :'Date' => date_timestamp,
                                      :'Authorization' => authorization_header,
                                      :content_type => 'application/json',
                                      :accept => :json)
      rescue => e
          e.response
      end
    end

    # Delete a target in a cloud database
    # https://developer.vuforia.com/library/articles/Solution/How-To-Delete-a-Target-Using-the-VWS-API
    def delete_target(target_id)
      # In order to delete the target, we have to set it to non-active.
      # Therefore,first retrieve target info and act accordingly to target info
      # returned
      target_data = JSON.parse(retrieve_target(target_id)) # have to JSON.parse
      # retrieve_target's results since they're in string format
      target_result_code = target_data["result_code"]
      if target_result_code != "AuthenticationFailure"
        if target_result_code != "UnknownTarget"
          target_active_flag = target_data["target_record"]["active_flag"]
          target_status = target_data["status"]
          if target_result_code == "Success"
            if target_active_flag == true && target_status == "success"
              return {:result_code => "TargetActive"}.to_json
            elsif target_active_flag == false && target_status == "success"
              # if we reached this point, the target is fine, inactive and
              # ready to be deleted
              date_timestamp = Time.now.httpdate
              target_id_url = TARGETS_URL + '/' + target_id
              target_id_suburl = '/targets' + '/' + target_id
              signature = self.build_signature(target_id_suburl, nil, 'DELETE', date_timestamp)
              raise ArgumentError.new('Signature returned nil. Aborting...') if signature == nil
              authorization_header = "VWS " + @accesskey + ":" + signature
                begin
                  RestClient.delete(target_id_url,
                                             :'Date' => date_timestamp,
                                             :'Authorization' => authorization_header)
                rescue => e
                  e.response
                end
            else
              return {:result_code => "#{target_status}"}.to_json
            end
          end
        else
          return {:result_code => "UnknownTarget"}.to_json
        end
      else
        return {:result_code => "AuthenticationFailure"}.to_json
      end
    end

    def list_duplicates(target_id)
      date_timestamp = Time.now.httpdate

      target_id_url = DUPLICATES_URL + '/' + target_id
      target_id_suburl = '/duplicates' + '/' + target_id

      signature = self.build_signature(target_id_suburl, nil, 'GET', date_timestamp)
      raise ArgumentError.new('Signature returned nil. Aborting...') if signature == nil
      authorization_header = "VWS " + @accesskey + ":" +  signature
      begin
        RestClient.get(target_id_url, :'Date' => date_timestamp,
                                      :'Authorization' => authorization_header)
      rescue => e
        e.response
      end
    end

  end
end
