module SharingCounter
  module API
    class Vk < APIprovider

      private

      def request_url
        "https://vk.com/share.php?act=count&index=1&url=#{ sharing_url }"
      end

      def parse(page)
        page.scan(/VK\.Share\.count\(\d, (\d+)\);/i)[0][0].to_i
      end

    end
  end
end
