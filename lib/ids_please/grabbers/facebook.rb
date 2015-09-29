class IdsPlease
  module Grabbers
    class Facebook < IdsPlease::Grabbers::Base

      def grab_link
        @link         = find_canonical_link || @link
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

      def find_canonical_link
        find_by_regex(/type="hidden" autocomplete="off" name="next" value="(.+?)" \/>/).gsub('/timeline/','')
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_network_id
        find_by_regex(/entity_id":"(\d+)"/)
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_avatar
        CGI.unescapeHTML(
          find_by_regex(/class="profilePic img" alt=".+" src="(.+?)"/).encode('utf-8')
        )
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_display_name
        CGI.unescapeHTML(
          find_by_regex(/<span itemprop="name">(.+?)<\/span>/).encode('utf-8')
        )
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_username
        @link.match(/[^"]+\/([^\/"]+)/)[1]
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
          find_by_regex(/class="_c24 _50f3">(.+?)<\/div>/).encode('utf-8')
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
