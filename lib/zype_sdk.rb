# frozen_string_literal: true

require 'caze'

require_relative './zype_sdk/client'
require_relative './zype_sdk/version'

require_relative './zype_sdk/use_cases/login'
require_relative './zype_sdk/use_cases/video'
require_relative './zype_sdk/use_cases/videos'

# Public: Entrypoint to the Zype API universe
module ZypeSDK
  include Caze

  has_use_case :login, UseCases::Login
  has_use_case :video, UseCases::Video
  has_use_case :videos, UseCases::Videos

  Error = Class.new(RuntimeError).freeze

  class << self
    attr_writer :app_key, :client_id, :client_secret

    def configure
      yield self
    end

    def app_key
      raise Error, 'Zype APP Key is required' unless @app_key
      @app_key
    end

    def client_id
      raise Error, 'Zype Client id is required' unless @client_id
      @client_id
    end

    def client_secret
      raise Error, 'Zype Client secret is required' unless @client_secret
      @client_secret
    end
  end
end
