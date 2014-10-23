require 'rubygems'
require "configuration"
require "api_provider"
require "client"

module SharingCounter
  extend Configuration

  def self.get_count(url, networks = Configuration::NETWORKS_KEYS)
    client = Client.new(url, networks)
    client.get_count
  end

end
