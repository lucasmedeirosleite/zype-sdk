# frozen_string_literal: true

require 'caze'

module ZypeSDK
  module UseCases
    # Public: Use case responsible to retrieve videos information
    class Videos
      include Caze

      export :get, as: :videos

      Result = Struct.new(:status, :content)

      RESPONSE_STATUS = {
        200 => :ok,
        401 => :unauthorized,
        500 => :internal_error
      }.freeze

      def initialize(params = {}, client: ZypeSDK::Client.new)
        @params = params
        @client = client
      end

      def get
        response = client.videos(params)
        status = RESPONSE_STATUS.fetch(response.status, :internal_error)
        Result.new(status, response.content)
      end

      private

      attr_reader :params, :client
    end
  end
end
