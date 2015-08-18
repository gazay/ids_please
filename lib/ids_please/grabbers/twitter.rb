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

      private

      def find_network_id
        page_source.scan(/data-user-id="(\d+)"/).flatten.first
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_avatar
        page_source.scan(/ProfileAvatar-image " src="([^"]+)"/).flatten.first
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_display_name
        page_source.scan(/ProfileHeaderCard-nameLink[^>]+>([^<]+)</).flatten.first
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_username
        page_source.scan(/<title>[^\(]+\(@([^\)]+)\)/).flatten.first
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_description
        CGI.unescapeHTML(page_source.scan(/ProfileHeaderCard-bio[^>]+>([^<]+)</).flatten.first.encode('utf-8')).strip
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_location
        CGI.unescapeHTML(page_source.scan(/ProfileHeaderCard-locationText[^>]+>([^<]+)</).flatten.first.encode('utf-8')).strip
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_join_date
        CGI.unescapeHTML(page_source.scan(/ProfileHeaderCard-joinDateText[^>]+>([^<]+)</).flatten.first.encode('utf-8')).strip
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_tweets
        page_source.scan(/statuses_count&quot;:(\d+),&quot;/).flatten.first.to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_followers
        page_source.scan(/followers_count&quot;:(\d+),&quot;/).flatten.first.to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_following
        page_source.scan(/friends_count&quot;:(\d+),&quot;/).flatten.first.to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_favorites
        page_source.scan(/favourites_count&quot;:(\d+),&quot;/).flatten.first.to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_listed
        page_source.scan(/listed_count&quot;:(\d+),&quot;/).flatten.first.to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end

    end
  end
end
