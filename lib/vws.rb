require "vws/version"
require 'rubygems'
require 'hmac-sha1'
require 'rest_client'




module Vws
  
  #constants for end point interface links
  #
  #
  #
  class Api

    def initialize(key=nil, secret=nil)
      @key     = key || ENV['VWS_KEY']
      @secrete = key || ENV['VWS_SECRET']
    end


    def timestamp
      return Time.now.utc.strftime("%Y%m%d%H%M%S")
    end


  end

end
