class IdsPlease
  module Grabbers
    class Twitter < IdsPlease::Grabbers::Base

      def grab_link
        @network_id   = find_network_id
        @avatar       = find_avatar
        @display_name = find_display_name
        @username     = find_username

        @counts = {
          tweets: find_tweets,
          following: find_following,
          followers: find_followers,
          favorites: find_favorites,
          lists: find_listed
        }.delete_if { |_k, v| v.nil? }

        @data = {
          description: find_description,
          location: find_location,
          join_date: find_join_date
        }.delete_if { |_k, v| v.nil? }

        self
      rescue => e
        record_error __method__, e.message
        return self
      end

      def find_network_id
        find_by_regex(/data-user-id="(\d+)"/)
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_avatar
        find_by_regex(/ProfileAvatar-image " src="([^"]+)"/)
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_display_name
        find_by_regex(/ProfileHeaderCard-nameLink[^>]+>([^<]+)</)
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_username
        find_by_regex(/<title>[^\(]+\(@([^\)]+)\)/)
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_description
        _desc = find_by_regex(/ProfileHeaderCard-bio[^>]+>([^<]+)</)
        CGI.unescapeHTML(_desc.encode('utf-8')).strip
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_location
        _loc = find_by_regex(/ProfileHeaderCard-locationText[^>]+>([^<]+)</)
        CGI.unescapeHTML(_loc.encode('utf-8')).strip
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_join_date
        _date = find_by_regex(/ProfileHeaderCard-joinDateText[^>]+>([^<]+)</)
        CGI.unescapeHTML(_date.encode('utf-8')).strip
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_tweets
        find_by_regex(/statuses_count&quot;:(\d+),&quot;/).to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_followers
        find_by_regex(/followers_count&quot;:(\d+),&quot;/).to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_following
        find_by_regex(/friends_count&quot;:(\d+),&quot;/).to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_favorites
        find_by_regex(/favourites_count&quot;:(\d+),&quot;/).to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_listed
        find_by_regex(/listed_count&quot;:(\d+),&quot;/).to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end

    end
  end
end
