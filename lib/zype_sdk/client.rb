# frozen_string_literal: true

require 'forwardable'
require 'httparty'

module ZypeSDK
  # Private: HTTP wrapper responsible to communicate with the Zype WEB API
  class Client
    extend Forwardable

    Response = Struct.new(:status, :content)

    def initialize(config = ZypeSDK)
      @config = config
    end

    def login(username:, password:)
      options = { 
        username: username, 
        password: password, 
        grant_type: 'password',
        client_id: client_id,
        client_secret: client_secret
      }

      zype_response = HTTParty.post("#{BASE_LOGIN_URI}/oauth/token", query: options)
      Response.new(zype_response.code, zype_response.parsed_response)
    end

    def video(id)
      get("videos/#{id}")
    end

    def videos(params = {})
      get('videos', params)
    end

    private

    BASE_API_URI = 'https://api.zype.com'
    BASE_LOGIN_URI = 'https://login.zype.com'

    attr_reader :config

    def_delegators :@config, :app_key, :client_id, :client_secret

    def get(uri, params = {})
      zype_response = HTTParty.get("#{BASE_API_URI}/#{uri}?app_key=#{app_key}", query: params)
      Response.new(zype_response.code, zype_response.parsed_response)
    end
  end
end
