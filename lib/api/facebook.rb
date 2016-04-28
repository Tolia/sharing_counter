module SharingCounter
  module API
    class Facebook < Provider
      JSON_KEY = "total_count"

      private

      def request_url
        "https://api.facebook.com/method/fql.query?format=json&query=select #{ json_key } from link_stat where url=\'#{ @sharing_url }\'"
      end

      def parse(page)
        JSON.parse(page)[0][json_key].to_i
      end

      def json_key
        @json_key ||= SharingCounter.options[:facebook][:json_key] || JSON_KEY
      end

    end
  end
end
