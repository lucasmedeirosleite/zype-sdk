# frozen_string_literal: true

require 'forwardable'
require 'httparty'

module ZypeSDK
  class Client
    extend Forwardable

    Response = Struct.new(:status, :content)

    def initialize(config)
      @config = config
    end

    def login(username:, password:)
      credentials = "username=#{username}&password=#{password}"
      params = "grant_type=password&client_id=#{client_id}&client_secret#{client_secret}&#{credentials}"
      zype_response = post("oauth/token?#{params}")
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

    def post(uri, params = {})
      HTTParty.post("#{BASE_LOGIN_URI}/#{uri}", params)
    end

    def_delegators :@config, :app_key, :client_id, :client_secret
  end
end
