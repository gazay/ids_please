require 'json'

class IdsPlease
  module Grabbers
    class Instagram < IdsPlease::Grabbers::Base

      def grab_link
        @network_id   = page_source.scan(/"user":{.+"id":"(\d+)"/).flatten.first
        @avatar       = page_source.scan(/"user":{.+"profile_pic_url":"([^"]+)"/).flatten.first.gsub('\\', '')
        @display_name = page_source.scan(/"user":{.+"full_name":"([^"]+)"/).flatten.first
        @username     = page_source.scan(/"user":{"username":"([^"]+)"/).flatten.first.gsub('\\', '')
        @data = {}
        {
          bio: page_source.scan(/"biography":"([^"]+)"/).flatten.first,
          website: page_source.scan(/"user":{.+"external_url":"([^"]+)"/).flatten.first.gsub('\\', ''),
        }.each do |k, v|
          next if v.nil? || v == ''
          @data[k] = CGI.unescapeHTML(v).strip
        end
        @counts = {
          media: page_source.scan(/"media":{"count":(\d+)/).flatten.first.to_i,
          followed_by: page_source.scan(/"followed_by":{"count":(\d+)/).flatten.first.to_i,
          follows: page_source.scan(/"follows":{"count":(\d+)/).flatten.first.to_i,
        }
        @display_name = @display_name.gsub(/\\u([\da-fA-F]{4})/) {|m| [$1].pack("H*").unpack("n*").pack("U*")}
        self
      rescue => e
        record_error __method__, e.message
        return self
      end
    end
  end
end
