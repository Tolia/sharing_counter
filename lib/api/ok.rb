module SharingCounter
  module API
    class Ok < APIprovider

      DEFAULT_MEASUREMENT = ''

      private

      def request_url
        "https://connect.ok.ru/dk?st.cmd=extLike&uid=odklcnt0&ref=#{ @sharing_url }"
      end

      def parse(page)
        /'(\d+)'\)/.match(page)[-1].to_i
      end

    end
  end
end
