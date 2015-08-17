class IdsPlease
  module Grabbers
    class Facebook < IdsPlease::Grabbers::Base

      def grab_link
        @network_id   = page_source.scan(/entity_id":"(\d+)"/).flatten.first
        @avatar       = page_source.scan(/og:image" content="([^"]+)"/).flatten.first
        @display_name = page_source.scan(/og:title" content="([^"]+)"/).flatten.first
        @username     = page_source.scan(/og:url" content="[^"]+\/([^\/"]+)"/).flatten.first
        @avatar       = CGI.unescapeHTML(@avatar.encode('utf-8')) if @avatar
        @display_name = CGI.unescapeHTML(@display_name.encode('utf-8')) if @display_name

        @counts = {
          likes:  likes,
          visits: visits,
        }.delete_if {|k,v| v.nil? }

        @data = {}
        {
          type: page_source.scan(/og:type" content="([^"]+)"/).flatten.first.encode('utf-8'),
          description: page_source.scan(/og:description" content="([^"]+)"/).flatten.first.encode('utf-8'),
        }.each do |k, v|
          next if v.nil? || v == ''
          @data[k] = CGI.unescapeHTML(v).strip
        end

        self
      rescue => e
        record_error __method__, e.message
        return self
      end

      def find_likes
        page_source.scan(/>([^"]+) <span class=".+">likes/).flatten.first.tr(',','').to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_visits
        page_source.scan(/likes.+>([^"]+)<\/span> <span class=".+">visits/).flatten.first.tr(',','').to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end
    end
  end
end
