class IdsPlease
  module Grabbers
    class Twitter < IdsPlease::Grabbers::Base

      def grab_link
        @network_id   = page_source.scan(/data-user-id="(\d+)"/).flatten.first
        @avatar       = page_source.scan(/ProfileAvatar-image " src="([^"]+)"/).flatten.first
        @display_name = page_source.scan(/ProfileHeaderCard-nameLink[^>]+>([^<]+)</).flatten.first
        @username     = page_source.scan(/<title>[^\(]+\(@([^\)]+)\)/).flatten.first
        @data = {}
        {
          description: page_source.scan(/ProfileHeaderCard-bio[^>]+>([^<]+)</).flatten.first.encode('utf-8'),
          location: page_source.scan(/ProfileHeaderCard-locationText[^>]+>([^<]+)</).flatten.first.encode('utf-8'),
          join_date: page_source.scan(/ProfileHeaderCard-joinDateText[^>]+>([^<]+)</).flatten.first.encode('utf-8'),
        }.each do |k, v|
          next if v.nil? || v == ''
          @data[k] = CGI.unescapeHTML(v).strip
        end
        @counts = {
          tweets: page_source.scan(/statuses_count&quot;:(\d+),&quot;/).flatten.first.to_i,
          following: page_source.scan(/friends_count&quot;:(\d+),&quot;/).flatten.first.to_i,
          followers: page_source.scan(/followers_count&quot;:(\d+),&quot;/).flatten.first.to_i,
          favorites: page_source.scan(/favourites_count&quot;:(\d+),&quot;/).flatten.first.to_i,
          lists: page_source.scan(/listed_count&quot;:(\d+),&quot;/).flatten.first.to_i,
        }
        self
      rescue => e
        record_error __method__, e.message
        return self
      end

    end
  end
end
