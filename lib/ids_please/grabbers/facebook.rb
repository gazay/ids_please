class IdsPlease
  module Grabbers
    class Facebook < IdsPlease::Grabbers::Base

      def grab
        @page_source = open(link).read
        @network_id  = @page_source.scan(/entity_id":"(\d+)"/).flatten.first
        @avatar = @page_source.scan(/og:image" content="([^"]+)"/).flatten.first
        @display_name = @page_source.scan(/og:title" content="([^"]+)"/).flatten.first
        @data = {
          type: @page_source.scan(/og:type" content="([^"]+)"/).flatten.first,
          description: @page_source.scan(/og:description" content="([^"]+)"/).flatten.first
        }
      end

    end
  end
end
