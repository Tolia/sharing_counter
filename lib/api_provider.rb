require 'rest_client'

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
        parse response if response && response.code == 200
      end

      private

      def request
        RestClient::Request.execute method: :get, url: URI.escape( request_url ), timeout: @timeout, open_timeout: @open_timeout rescue nil
      end

      def request_url
      end

      def parse(page)
        JSON.parse(page)[@measurement].to_i
      end

    end
  end
end