# frozen_string_literal: true

require 'caze'

module ZypeSDK
  module UseCases
    # Public: Use case which performs the login action
    class Login
      include Caze

      export :login

      Result = Struct.new(:status, :content)

      RESPONSE_STATUS = {
        200 => :ok,
        401 => :unauthorized,
        500 => :internal_error
      }.freeze

      def initialize(username:, password:, client: ZypeSDK::Client.get)
        @username = username
        @password = password
        @client = client
      end

      def login
        response = client.login(username: username, password: password)
        status = RESPONSE_STATUS.fetch(response.status, :internal_error)
        Result.new(status, response.content)
      end

      private

      attr_reader :username, :password, :client
    end
  end
end
