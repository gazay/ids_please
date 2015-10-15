class IdsPlease
  module Grabbers
    class Vimeo < IdsPlease::Grabbers::Base

      def grab_link
        # @network_id   = find_network_id
        @avatar       = find_avatar
        @display_name = find_display_name
        # @username     = find_username

        self
      rescue => e
        record_error __method__, e.message
        return self
      end

      def find_avatar
        find_by_regex(/og:image" content="([^"]+)"/)
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_display_name
        find_by_regex(/og:title" content"([^"]+)"/)
      rescue => e
        record_error __method__, e.message
        return nil
      end
    end
  end
end
