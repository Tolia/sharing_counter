module SharingCounter
  module Configuration
    HTTP_USER_AGENT = "SharingCounter:#{ SharingCounter::VERSION }"
    NETWORKS_KEYS = ::SharingCounter::Client::NETWORKS_API.keys
    attr_accessor *NETWORKS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      opts = { user_agent: HTTP_USER_AGENT }
      NETWORKS_KEYS.each_with_object(opts) do |key, options|
        options[key] = send(key)
      end
    end

    # Reset all configuration options to defaults
    def reset
      NETWORKS_KEYS.each do |network_key|
        send "#{network_key}=", {}
      end
    end
  end
end
