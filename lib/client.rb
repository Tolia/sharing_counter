require 'thread'

module SharingCounter
  class Client
    Dir[File.expand_path('../api/*.rb', __FILE__)].each{|f| require f}

    NETWORKS_API = {
      facebook:  ::SharingCounter::API::Facebook,
      twitter:   ::SharingCounter::API::Twitter,
      vk:        ::SharingCounter::API::Vk,
      ok:        ::SharingCounter::API::Ok,
      pinterest: ::SharingCounter::API::Pinterest
    }

    def initialize(url, networks=NETWORKS_API.keys)
      @sharing_url = url
      @networks = networks
    end

    def get_count
      start = Time.now
      data  = request_to_networks
      data[:url]   = @sharing_url.to_s
      data[:data]  = start
      data[:delay] = Time.now - start
      data
    end

  private

    def request_to_networks
      mutex   = Mutex.new
      counters = { errors: {} }

      @networks.map do |network|
        api = NETWORKS_API[network] || raise('Social network is not supported')

        Thread.new(@sharing_url) do |url|
          provider = api.new(url)
          count, error = provider.get_count

          mutex.synchronize do
            counters[network] = count if error.nil?
            counters[:errors][network] = error if !error.nil?
          end
        end
      end.each(&:join)

      counters
    end
  end
end
