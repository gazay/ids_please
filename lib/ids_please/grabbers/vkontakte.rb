class IdsPlease
  module Grabbers
    class Vkontakte < IdsPlease::Grabbers::Base
      def grab_link
        @page_source   = open(link, 'User-Agent' => agent).read.encode('utf-8')
        @network_id    = find_by_regex(/href="\/wall(-\d+)_/)
        @username      = @link.to_s.split('vk.com/').last.gsub('/', '')
        @avatar        = find_by_regex(/page_avatar.+\n.+src="([^"]+)/)
        @avatar        = CGI.unescapeHTML(@avatar) if @avatar
        @display_name  = find_by_regex(/page_name">([^<]+)/)
        @display_name  = CGI.unescapeHTML(@display_name) if @display_name
        @data = {
          description: find_by_regex(/description" content="([^"]+)/)
        }
        @data[:description] = CGI.unescapeHTML(@data[:description]) if @data[:description]
        self
      rescue => e
        record_error __method__, e.message
        return self
      end
    end
  end
end
