require 'json'

class IdsPlease
  module Grabbers
    class Instagram < IdsPlease::Grabbers::Base

      def grab_link
        @page_source ||= open(link).read
        @network_id  = @page_source.scan(/"user":{.+"id":"(\d+)"/).flatten.first
        @avatar  = @page_source.scan(/"user":{.+"profile_picture":"([^"]+)"/).flatten.first
        @avatar = CGI.unescapeHTML(@avatar)
        @display_name  = @page_source.scan(/"user":{.+"full_name":"([^"]+)"/).flatten.first
        @display_name = CGI.unescapeHTML(@display_name)
        counts = @page_source.scan(/"user":{.+"counts":({[^}]+})/).flatten.first
        counts = JSON.parse counts
        @data = {
          username: @page_source.scan(/"user":{.+"username":"([^"]+)"/).flatten.first,
          bio: @page_source.scan(/"user":{.+"bio":"([^"]+)"/).flatten.first,
          website: @page_source.scan(/"user":{.+"website":"([^"]+)"/).flatten.first,
          counts: counts
        }

        self
      end

    end
  end
end
