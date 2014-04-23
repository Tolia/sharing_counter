require "active_support/all"

module SharingCounter

  class Client
    Dir[File.expand_path('../api/*.rb', __FILE__)].each{|f| require f}

    ATTRS = [:sharing_url] + Configuration::NETWORKS_KEYS

    attr_accessor *ATTRS

    def initialize(sharing_url, networks=[])
      @sharing_url = sharing_url
      networks.each do |network|
        network_api = "SharingCounter::API::#{network.to_s.capitalize }".constantize
        send "#{network}=", network_api.new(sharing_url)
      end
    end

    def get_count
      start = Time.now
      request = {
        url: @sharing_url,
        data: start,
      }.merge networks_requests
      request[:delay] = Time.now - start
      request
    end

    private

    def networks_requests
      request = {}
      Configuration::NETWORKS_KEYS.each do |key|
        network = send key
        request[key] = network.count if network
      end
      request
    end

  end

end