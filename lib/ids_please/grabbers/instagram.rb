require 'json'

class IdsPlease
  module Grabbers
    class Instagram < IdsPlease::Grabbers::Base

      def grab_link
        @network_id   = find_network_id
        @avatar       = find_avatar
        @display_name = find_display_name
        @username     = find_username

        @counts = {
          media: find_media,
          followed_by: find_followed_by,
          follows: find_follows
        }.delete_if { |_k, v| v.nil? }

        @data = {
          bio: find_bio,
          website: find_website
        }.delete_if { |_k, v| v.nil? }

        self
      rescue => e
        record_error __method__, e.message
        return self
      end

      private

      def find_network_id
        find_by_regex(/"id": "(\d+)"/)
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_avatar
        find_by_regex(/"user":\s?{.+"profile_pic_url":\s?"([^"]+)"/).gsub('\\', '')
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_display_name
        _display_name = find_by_regex(/"user":\s?{.+"full_name":\s?"([^"]+)"/)
        _display_name.gsub(/\\u([\da-fA-F]{4})/) { |_m|
          [Regexp.last_match(1)].pack('H*').unpack('n*').pack('U*')
        }
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_username
        find_by_regex(/"username":\s?"([^"]+)"/).to_s.gsub('\\', '')
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_bio
        CGI.unescapeHTML(find_by_regex(/"biography":\s?"([^"]+)"/).to_s).strip
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_website
        CGI.unescapeHTML(find_by_regex(/"user":\s?{.+"external_url":\s?"([^"]+)"/).to_s.gsub('\\', '')).strip
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_media
        find_by_regex(/"media":\s?{"count":\s?(\d+)/).to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_followed_by
        find_by_regex(/"followed_by":\s?{"count":\s?(\d+)/).to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_follows
        find_by_regex(/"follows":\s?{"count":\s?(\d+)/).to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end

    end
  end
end
