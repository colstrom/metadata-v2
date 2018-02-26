
# -*- ruby -*-

require 'base64' # Ruby Standard Library

module Metadata
  module V2
    class Response
      def initialize(frame)
        @frame = frame
        self
      end

      attr_reader :frame

      def to_s
        frame + "\n"
      end

      def protocol
        @protocol ||= frame.split(' ')[0]
      end

      def length
        @length ||= frame.split(' ')[1].to_i
      end

      def checksum
        @checksum ||= frame.split(' ')[2]
      end

      def body
        @body ||= frame.split(' ').drop(3).join(' ')
      end

      def id
        @id ||= body.split(' ')[0]
      end

      def code
        @code ||= body.split(' ')[1]
      end

      def payload
        @payload ||= body.split(' ')[2]
      end

      def decode
        Base64.decode64 payload if payload
      end
    end
  end
end
