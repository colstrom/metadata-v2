
# -*- ruby -*-

require 'socket' # Ruby Standard Library

require_relative 'request'
require_relative 'response'
require_relative 'socket_paths'

module Metadata
  module V2
    class Client
      def initialize(path = nil)
        @socket = UNIXSocket.new path || ENV.fetch('METADATA_SOCKET') { discover }
        self
      end

      def keys
        request! 'KEYS'
        block_given? ? yield(response!) : response!
      end

      def get(key)
        request! 'GET', key.to_s
        block_given? ? yield(response!) : response!
      end

      def put(key, value)
        request! 'PUT', key.to_s, value.to_s
        block_given? ? yield(response!) : response!
      end

      def delete(key)
        request! 'DELETE', key.to_s
        block_given? ? yield(response!) : response!
      end

      private

      def discover
        SOCKET_PATHS.find { |path| File.socket? path } or raise Errno::ENOENT
      end

      def raw_request!(message)
        @socket.sendmsg message.to_s
      end

      def raw_response!
        @socket.readline
      end

      def flush!
        raw_request! "\n"
        "invalid command\n" == raw_response!
      end

      def negotiate!
        raw_request! "NEGOTIATE V2\n"
        "V2_OK\n" == raw_response!
      end

      def request!(*args)
        raw_request! Request.new(*args)
      end

      def response!
        Response.new raw_response!
      end
    end
  end
end
