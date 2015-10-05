class IdsPlease
  module Grabbers
    class GooglePlus < IdsPlease::Grabbers::Base

      def grab_link
        @network_id   = find_network_id
        @avatar       = find_avatar
        @display_name = find_display_name
        @username     = find_username

        @counts = {
          followers: find_followers,
          views: find_views
        }.delete_if { |_k, v| v.nil? }

        @data = {
          description: find_description
        }.delete_if { |_k, v| v.nil? }

        self
      rescue => e
        record_error __method__, e.message
        return self
      end

      def find_network_id
        find_by_regex(/data:\["(\d+)",/)
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_avatar
        if partial_avatar = find_by_regex(/guidedhelpid="profile_photo"><img src="([^"]+)"/)
          "https:#{partial_avatar}"
        else
          return nil
        end
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_display_name
        find_by_regex(/og:title" content="([^"]+)"/).split('-').try(:first).try(:strip)
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_username
        "+#{find_by_regex(/&quot;https:\/\/plus.google.com\/\+(.+?)&quot;/)}"
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_description
        find_by_regex(/name="Description" content="([^"]+)">/).encode('utf-8')
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_followers
        if followers = find_by_regex(/">([^"]+)<\/span> followers</)
          followers.tr(',', '').to_i
        end
      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_views
        if views = find_by_regex(/">([^"]+)<\/span> views</)
          views.tr(',', '').to_i
        end
      rescue => e
        record_error __method__, e.message
        return nil
      end

    end
  end
end
