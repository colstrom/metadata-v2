
# -*- ruby -*-

module Metadata
  module V2
    SOCKET_PATHS = [
      "/.zonecontrol/metadata.sock",
      "/native/.zonecontrol/metadata.sock",
      "/var/run/smartdc/metadata.sock"
    ].freeze
  end
end
