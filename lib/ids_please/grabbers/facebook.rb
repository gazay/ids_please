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

      def find_network_id
        page_source.scan(/entity_id":"(\d+)"/).flatten.first
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_avatar
        CGI.unescapeHTML(page_source.scan(/og:image" content="([^"]+)"/).flatten.first.encode('utf-8'))
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_display_name
        CGI.unescapeHTML(page_source.scan(/og:title" content="([^"]+)"/).flatten.first.encode('utf-8'))
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_username
        page_source.scan(/og:url" content="[^"]+\/([^\/"]+)"/).flatten.first
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_type
        CGI.unescapeHTML(page_source.scan(/og:type" content="([^"]+)"/).flatten.first.encode('utf-8')).strip
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_description
        CGI.unescapeHTML(page_source.scan(/og:description" content="([^"]+)"/).flatten.first.encode('utf-8')).strip
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_likes
        if likes = page_source.scan(/>([^"]+) <span class=".+">likes/).flatten.first
          likes.tr(',', '').to_i
        end
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_visits
        if visits = page_source.scan(/likes.+>([^"]+)<\/span> <span class=".+">visits/).flatten.first
          visits.tr(',', '').to_i
        end
      rescue => e
        record_error __method__, e.message
        return nil
      end
    end
  end
end
