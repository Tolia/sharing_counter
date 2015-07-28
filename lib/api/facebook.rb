module SharingCounter
  module API
    class Facebook < APIprovider

      DEFAULT_MEASUREMENT = "shares"

      private

      def request_url
        "http://graph.facebook.com/?id=#{ @sharing_url }"
      end

      def parse(page)
        JSON.parse(page)[@measurement].to_i
      end

    end
  end
end