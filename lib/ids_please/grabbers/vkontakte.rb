class IdsPlease
  module Grabbers
    class Vkontakte < IdsPlease::Grabbers::Base

      def grab
        agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36'
        @page_source ||= open(link, 'User-Agent' => agent).read.encode('utf-8')
        @network_id  = @page_source.scan(/href="\/wall(-\d+)_/).flatten.first
        @avatar = @page_source.scan(/page_avatar.+\n.+src="([^"]+)/).flatten.first
        @avatar = CGI.unescapeHTML(@avatar)
        @display_name = @page_source.scan(/page_name">([^<]+)/).flatten.first
        @display_name = CGI.unescapeHTML(@display_name)
        @data = {
          description: CGI.unescapeHTML(@page_source.scan(/description" content="([^"]+)/).flatten.first)
        }
      end

    end
  end
end
