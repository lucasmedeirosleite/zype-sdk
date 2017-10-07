# frozen_string_literal: true

require 'forwardable'
require 'httparty'

module ZypeSDK
  # Public: HTTP wrapper responsible to communicate with the Zype WEB API
  class Client
    extend Forwardable

    Response = Struct.new(:status, :content)

    def initialize(config)
      @config = config
    end

    def login(username:, password:)
      user_credentials = "username=#{username}&password=#{password}"
      client_credentials = "client_id=#{client_id}&client_secret=#{client_secret}"
      params = "grant_type=password&#{user_credentials}&#{client_credentials}"
      url = "#{BASE_LOGIN_URI}/oauth/token?#{params}"      

      zype_response = HTTParty.post(url)
      Response.new(zype_response.code, zype_response.parsed_response)
    end

    def video(id)
    end

    def videos(params = {})
    end

    private

    BASE_API_URI = 'https://api.zype.com'
    BASE_LOGIN_URI = 'https://login.zype.com'

    attr_reader :config

    def_delegators :@config, :app_key, :client_id, :client_secret
  end
end
