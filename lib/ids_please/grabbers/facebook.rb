class IdsPlease
  module Grabbers
    class Facebook < IdsPlease::Grabbers::Base

      def grab_link
        @network_id   = find_network_id
        @avatar       = find_avatar
        @display_name = find_display_name
        @username     = find_username

        @counts = {
          likes:  find_likes,
          visits: find_visits
        }.delete_if { |_k, v| v.nil? }

        @data = {
          type: find_type,
          description: find_description
        }.delete_if { |_k, v| v.nil? }

        self
      rescue => e
        record_error __method__, e.message
        return self
      end

      private

      def find_network_id
        find_by_regex(/entity_id":"(\d+)"/)
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_avatar
        CGI.unescapeHTML(
          find_by_regex(/og:image" content="([^"]+)"/).encode('utf-8')
        )
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_display_name
        CGI.unescapeHTML(
          find_by_regex(/og:title" content="([^"]+)"/).encode('utf-8')
        )
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_username
        find_by_regex(/og:url" content="[^"]+\/([^\/"]+)"/)
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_type
        CGI.unescapeHTML(
          find_by_regex(/og:type" content="([^"]+)"/).encode('utf-8')
        ).strip
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_description
        CGI.unescapeHTML(
          find_by_regex(/og:description" content="([^"]+)"/).encode('utf-8')
        ).strip
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_likes
        if likes = find_by_regex(/>([^"]+) <span class=".+">likes/)
          likes.tr(',', '').to_i
        end
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_visits
        if visits = find_by_regex(/likes.+>([^"]+)<\/span> <span class=".+">visits/)
          visits.tr(',', '').to_i
        end
      rescue => e
        record_error __method__, e.message
        return nil
      end

    end
  end
end
