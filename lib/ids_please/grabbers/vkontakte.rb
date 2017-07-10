class IdsPlease
  module Grabbers
    class Vkontakte < IdsPlease::Grabbers::Base
      def grab_link
        agent          = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36'
        @page_source ||= open(link, 'User-Agent' => agent).read.encode('utf-8')

        @network_id    = find_network_id
        @username      = find_username
        @avatar        = find_avatar
        @display_name  = find_display_name

        @data = {
          description: find_description
        }
        self
      rescue => e
        record_error __method__, e.message
        return self
      end

      private

      def find_avatar
        CGI.unescapeHTML(
          find_by_regex(/page_avatar_img" src="([^"]+)/) ||
          find_by_regex(/<img src="([^"]+).+class="post_img"/)
        )
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_network_id
        find_by_regex(/href="\/wall(-\d+)_/)
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_display_name
        CGI.unescapeHTML(
          find_by_regex(/page_name">([^<]+)/)
        )
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_username
        @link.to_s.split('vk.com/').last.gsub('/', '')
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_description
        CGI.unescapeHTML(
          find_by_regex(/description" content="([^"]+)/)
        )
      rescue => e
        record_error __method__, e.message
        return nil
      end
    end
  end
end
