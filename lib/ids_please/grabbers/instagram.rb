require 'json'

class IdsPlease
  module Grabbers
    class Instagram < IdsPlease::Grabbers::Base

      def grab_link
        @page_source ||= open(link).read
        @network_id  = @page_source.scan(/"user":{.+"id":"(\d+)"/).flatten.first
        @avatar  = @page_source.scan(/"user":{.+"profile_picture":"([^"]+)"/).flatten.first.gsub('\\', '')
        @display_name  = @page_source.scan(/"user":{.+"full_name":"([^"]+)"/).flatten.first
        @username  = @page_source.scan(/"user":{.+"username":"([^"]+)"/).flatten.first.gsub('\\', '')
        counts = @page_source.scan(/"user":{.+"counts":({[^}]+})/).flatten.first
        counts = JSON.parse counts
        @data = {}
        {
          bio: @page_source.scan(/"user":{.+"bio":"([^"]+)"/).flatten.first,
          website: @page_source.scan(/"user":{.+"website":"([^"]+)"/).flatten.first.gsub('\\', ''),
          counts: counts
        }.each do |k, v|
          next if v.nil? || v == '' || !v.is_a?(String)
          @data[k] = v.gsub(/\\u([\da-fA-F]{4})/) {|m| [$1].pack("H*").unpack("n*").pack("U*")}
        end
        @display_name = @display_name.gsub(/\\u([\da-fA-F]{4})/) {|m| [$1].pack("H*").unpack("n*").pack("U*")}
        self
      rescue => e
        p e
        return self
      end

    end
  end
end
