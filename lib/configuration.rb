require "active_support/all"

module SharingCounter

  module Configuration

    NETWORKS_KEYS = [
      :facebook,
      :twitter,
      :vk,
      :ok
    ].freeze

    DEFAULT_SETTINGS_KEYS = [
      :timeout,
      :open_timeout
    ].freeze

    INDIVIDUAL_SETTINGS_KEYS = [
      :measurement,
      :app_id
    ].freeze

    SETTINGS_KEYS = DEFAULT_SETTINGS_KEYS + INDIVIDUAL_SETTINGS_KEYS

    DEFAULT_TIMEOUT      = 2
    DEFAULT_OPEN_TIMEOUT = 2

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
      NETWORKS_KEYS.inject({}) do |option, key|
        option.merge! key => send(key)
      end
    end

    # Reset all configuration options to defaults
    def reset
      NETWORKS_KEYS.each do |network_key|
        network = {}
        DEFAULT_SETTINGS_KEYS.each do |key|
          network[key] = "SharingCounter::Configuration::#{default(key)}".constantize
        end
        INDIVIDUAL_SETTINGS_KEYS.each do |key|
          network[key] = "SharingCounter::API::#{network_key.to_s.capitalize }::#{ default(key) }".constantize
        end
        send "#{network_key}=", network
      end
    end

    private

    def default(key)
      "DEFAULT_#{ key.to_s.upcase }"
    end
  end
end