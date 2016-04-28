module SharingCounter
  module API
    class Pinterest < Provider
      JSON_KEY = 'count'

      private

      def request_url
        "http://api.pinterest.com/v1/urls/count.json?callback=receiveCount&url=#{ @sharing_url }"
      end

      def parse(page)
        json = page.gsub!(/^receiveCount\((.*)\)$/, "\\1")
        JSON.parse(json)[JSON_KEY].to_i
      end

    end
  end
end
