# frozen_string_literal: true

require_relative './zype_sdk/version'

# Public: Entrypoint to the Zype API universe
module ZypeSDK

  Error = Class.new(RuntimeError).freeze

  class << self
    attr_accessor :app_key, :client_id, :client_secret

    def configuration
      yield self
    end

    def app_key
      raise Error.new('Zype APP Key is required') unless @app_key
      @app_key
    end

    def client_id
      raise Error.new('Zype Client id is required') unless @client_id
      @client_id
    end

    def client_secret
      raise Error.new('Zype Client secret is required') unless @client_secret
      @client_secret
    end
  end
end
