module SharingCounter
  module API
    class Vk < APIprovider

      private

      def request_url
        "http://vk.com/widget_like.php?app=#{ @app_id }&page=0&url=#{ @sharing_url }&type=mini"
      end

      def parse(page)
        page.force_encoding("ISO-8859-1").encode("utf-8", replace: nil).scan(/var counter = ([0-9]+);/)[0][0].to_i
      end

    end
  end
end