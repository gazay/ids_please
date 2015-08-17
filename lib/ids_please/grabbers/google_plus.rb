class IdsPlease
  module Grabbers
    class GooglePlus < IdsPlease::Grabbers::Base

      def grab_link
        @network_id   = page_source.scan(/data-oid="(\d+)"/).flatten.first
        @avatar       = 'https:' + page_source.scan(/guidedhelpid="profile_photo"><img src="([^"]+)"/).flatten.first
        @display_name = page_source.scan(/og:title" content="([^"]+)"/).flatten.first.gsub(' - Google+','')
        @username     = '+' + page_source.scan(/&quot;https:\/\/plus.google.com\/\+(.+?)&quot;/).flatten.first
        @data = {
          description: page_source.scan(/name="Description" content="([^"]+)">/).flatten.first.encode('utf-8')
        }
        @counts = {
          followers:  page_source.scan(/">([^"]+)<\/span> followers</).flatten.first.tr(',','').to_i,
          views: page_source.scan(/">([^"]+)<\/span> views</).flatten.first.tr(',','').to_i,
        }
        self
      rescue => e
        record_error __method__, e.message
        return self
      end
    end
  end
end
