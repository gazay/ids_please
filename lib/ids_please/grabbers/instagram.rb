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
        find_by_regex(/"user":{.+"id":"(\d+)"/)
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_avatar
        find_by_regex(/"user":{.+"profile_pic_url":"([^"]+)"/).gsub('\\', '')
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_display_name
        _display_name = find_by_regex(/"user":{.+"full_name":"([^"]+)"/)
        _display_name.gsub(/\\u([\da-fA-F]{4})/) { |_m|
          [Regexp.last_match(1)].pack('H*').unpack('n*').pack('U*')
        }
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_username
        find_by_regex(/"user":{"username":"([^"]+)"/).gsub('\\', '')
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_bio
        CGI.unescapeHTML(find_by_regex(/"biography":"([^"]+)"/)).strip
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_website
        CGI.unescapeHTML(find_by_regex(/"user":{.+"external_url":"([^"]+)"/).gsub('\\', '')).strip
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_media
        find_by_regex(/"media":{"count":(\d+)/).to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_followed_by
        find_by_regex(/"followed_by":{"count":(\d+)/).to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_follows
        find_by_regex(/"follows":{"count":(\d+)/).to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end

    end
  end
end
