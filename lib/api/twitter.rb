module SharingCounter
  module API
    class Twitter < Provider
      JSON_KEY = "count"

      private

      def request_url
        "https://urls.api.twitter.com/1/urls/count.json?url=#{ @sharing_url }"
      end

      def parse(page)
        JSON.parse(page)[JSON_KEY].to_i
      end

    end
  end
end
