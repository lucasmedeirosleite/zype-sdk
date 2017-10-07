# frozen_string_literal

require 'caze'

module ZypeSDK
  module UseCases
    class Video
      include Caze

      export :get, as: :video

      Result = Struct.new(:status, :content)

      RESPONSE_STATUS = {
        200 => :ok,
        401 => :unauthorized,
        404 => :not_found,
        500 => :internal_error
      }.freeze

      def initialize(video_id, client: ZypeSDK::Client.new)
        @video_id = video_id
        @client = client
      end

      def get
        response = client.video(video_id)
        status = RESPONSE_STATUS.fetch(response.status, :internal_error)
        Result.new(status, response.content)
      end

      private

      attr_reader :video_id, :client
    end
  end
end
