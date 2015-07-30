module SharingCounter
  module API
    class Twitter < APIprovider

      DEFAULT_MEASUREMENT = "count"

      private

      def request_url
        "http://urls.api.twitter.com/1/urls/count.json?url=#{ sharing_url }"
      end

    end
  end
end
