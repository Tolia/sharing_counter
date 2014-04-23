module SharingCounter
  module API
    class Facebook < APIprovider

      DEFAULT_MEASUREMENT = "total_count"

      private

      def request_url
        "http://api.ak.facebook.com/restserver.php?v=1.0&method=links.getStats&urls=#{ @sharing_url }&format=json"
      end

      def parse(page)
        JSON.parse(page)[0][@measurement].to_i
      end

    end
  end
end