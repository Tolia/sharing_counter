module SharingCounter
  module API
    class Facebook < APIprovider

      DEFAULT_MEASUREMENT = "share_count"

      private

      def request_url
        "https://graph.facebook.com/fql?q=SELECT share_count FROM link_stat WHERE url='#{ @sharing_url }'"
      end

      def parse(page)
        JSON.parse(page)['data'][0][@measurement].to_i
      end

    end
  end
end