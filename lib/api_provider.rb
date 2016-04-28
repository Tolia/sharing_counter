require 'net/http'
require 'json'

module SharingCounter
  module API
    class Provider
      SETTINGS_KEYS = []

      attr_accessor *SETTINGS_KEYS

      def initialize(sharing_url)
        @sharing_url = sharing_url
        SharingCounter.options[name].each do |key, val|
          instance_variable_set "@#{key}", val
        end
      end


      def get_count
        # return [count, errors]
        res = Net::HTTP.get_response URI.parse(request_url)
        res['User-Agent'] = SharingCounter.options[:user_agent]
        [parse(res.body), nil]
      rescue SocketError => e
        [nil, e]
      end

    private


      def name
        self.class.name.split('::').last.downcase.to_sym
      end

      def request_url
        raise ''
      end

      def parse(page)
        raise ''
      end
    end
  end
end
