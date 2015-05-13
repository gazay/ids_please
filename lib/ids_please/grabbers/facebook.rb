class IdsPlease
  module Grabbers
    class Facebook < IdsPlease::Grabbers::Base

      def grab_link
        @page_source ||= open(link).read
        @network_id  = @page_source.scan(/entity_id":"(\d+)"/).flatten.first
        @avatar = @page_source.scan(/og:image" content="([^"]+)"/).flatten.first
        @avatar = CGI.unescapeHTML(@avatar)
        @display_name = @page_source.scan(/og:title" content="([^"]+)"/).flatten.first
        @display_name = CGI.unescapeHTML(@display_name)
        @data = {
          type: CGI.unescapeHTML(@page_source.scan(/og:type" content="([^"]+)"/).flatten.first),
          description: CGI.unescapeHTML(@page_source.scan(/og:description" content="([^"]+)"/).flatten.first)
        }

        self
      end

    end
  end
end
