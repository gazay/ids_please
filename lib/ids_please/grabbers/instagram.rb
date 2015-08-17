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
          follows: find_follows,
        }.delete_if {|k,v| v.nil? }

        @data = {
          bio: find_bio,
          website: find_website,
        }.delete_if {|k,v| v.nil? }

        self
      rescue => e
        record_error __method__, e.message
        return self
      end

      def find_network_id
        page_source.scan(/"user":{.+"id":"(\d+)"/).flatten.first
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_avatar
        page_source.scan(/"user":{.+"profile_pic_url":"([^"]+)"/).flatten.first.gsub('\\', '')
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_display_name
        page_source.scan(/"user":{.+"full_name":"([^"]+)"/).flatten.first.gsub(/\\u([\da-fA-F]{4})/) {|m| [$1].pack("H*").unpack("n*").pack("U*")}
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_username
        page_source.scan(/"user":{"username":"([^"]+)"/).flatten.first.gsub('\\', '')
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_bio
        CGI.unescapeHTML(page_source.scan(/"biography":"([^"]+)"/).flatten.first).strip
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_website
        CGI.unescapeHTML(page_source.scan(/"user":{.+"external_url":"([^"]+)"/).flatten.first.gsub('\\', '')).strip
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_media
        page_source.scan(/"media":{"count":(\d+)/).flatten.first.to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_followed_by
        page_source.scan(/"followed_by":{"count":(\d+)/).flatten.first.to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_follows
        page_source.scan(/"follows":{"count":(\d+)/).flatten.first.to_i
      rescue => e
        record_error __method__, e.message
        return nil
      end
    end
  end
end
