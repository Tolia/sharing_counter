module SharingCounter
  module API
    class Facebook < Provider
      JSON_KEY = "share_count"

      private

      def request_url
        "https://graph.facebook.com/?id=#{ @sharing_url }"
      end

      def parse(page)
        JSON.parse(page)['share'][json_key].to_i
      end

      def json_key
        @json_key ||= SharingCounter.options[:facebook][:json_key] || JSON_KEY
      end

    end
  end
end
