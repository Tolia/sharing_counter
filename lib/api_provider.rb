require 'faraday'

module SharingCounter
  module API
    class APIprovider

      ATTRS               = [:sharing_url]
      DEFAULT_MEASUREMENT = false
      DEFAULT_APP_ID      = false

      attr_accessor *(ATTRS + ::SharingCounter::Configuration::SETTINGS_KEYS)

      def initialize(sharing_url)
        @sharing_url = sharing_url
        options      = SharingCounter.options[self.class.name.demodulize.downcase.to_sym]
        options.each do |key,val|
          send "#{key}=", val
        end
      end

      def count
        response = request
        parse response.body if response.body && response.status == 200
      end

    private

      def request
        Faraday.get do |r|
          r.url URI.escape(request_url)
          r.options = {
            timeout:      @timeout,
            open_timeout: @open_timeout
          }
        end
      end

      def request_url
      end

      def parse(page)
        JSON.parse(page)[@measurement].to_i
      end

      def sharing_url
        url = URI.parse(@sharing_url)
        url = "http://" + url.to_s unless url.scheme
        @url ||= url.to_s
      end

    end
  end
end
