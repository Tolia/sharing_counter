module SharingCounter
  module API
    class Facebook < APIprovider

      DEFAULT_MEASUREMENT = "total_count"

      private

      def request_url
        "https://api.facebook.com/method/fql.query?format=json&query=select commentsbox_count, click_count, total_count, comment_count, like_count, share_count from link_stat where url=\'#{@sharing_url}\'"
      end

      def parse(page)
        JSON.parse(page)[0][@measurement].to_i
      end

    end
  end
end
