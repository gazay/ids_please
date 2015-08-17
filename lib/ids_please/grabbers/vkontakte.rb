class IdsPlease
  module Grabbers
    class Vkontakte < IdsPlease::Grabbers::Base

      def grab_link
        agent          = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36'
        @page_source ||= open(link, 'User-Agent' => agent).read.encode('utf-8')
        @network_id    = page_source.scan(/href="\/wall(-\d+)_/).flatten.first
        @username      = @link.to_s.split('vk.com/').last.gsub('/', '')
        @avatar        = page_source.scan(/page_avatar.+\n.+src="([^"]+)/).flatten.first
        @avatar        = CGI.unescapeHTML(@avatar) if @avatar
        @display_name  = page_source.scan(/page_name">([^<]+)/).flatten.first
        @display_name  = CGI.unescapeHTML(@display_name) if @display_name
        @data = {
          description: page_source.scan(/description" content="([^"]+)/).flatten.first
        }
        @data[:description] = CGI.unescapeHTML(@data[:description]) if @data[:description]
        self
      rescue => e
        record_error __method__, e.message
        return self
      end

      def find_network_id

      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_avatar

      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_display_name

      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_username

      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_type

      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_description

      rescue => e
        record_error __method__, e.message
        return nil
      end

    end
  end
end
