
# -*- ruby -*-

require 'base64' # Ruby Standard Library
require 'zlib'   # Ruby Standard Library

module Metadata
  module V2
    class Request
      def initialize(operation, *args)
        @operation = operation
        @args      = args
        self
      end

      attr_reader :operation, :args

      def id
        @id ||= 8.times.map { rand (0..15) }.map { |n| n.to_s(16) }.reduce(:+)
      end

      def payload
        case args.size
        when 1
          Base64.encode64(*args).chomp
        when 2
          Base64.encode64(args.map { |arg| Base64.encode64(arg).chomp }.join(' ')).chomp
        end
      end

      def body
        @body ||= [id, operation, payload].compact.reject(&:empty?).join(' ')
      end

      def checksum
        @checksum ||= Zlib.crc32(body).to_s(16)
      end

      def to_s
        ['V2', body.length, checksum, body].join(' ') + "\n"
      end
    end
  end
end
