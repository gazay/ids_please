require 'json'

class IdsPlease
  module Grabbers
    class Mailru < IdsPlease::Grabbers::Base

      def grab_link
        @page_source  ||= open(link).read.encode('utf-8')
        uid_url         = "http://appsmail.ru/platform/#{link.split('/')[-2..-1].join('/')}"
        @network_id     = JSON.parse(open(uid_url).read)['uid']
        @username, type = get_name_and_type(link)
        @avatar         = page_source.scan(/profile__avatar" src="([^"]+)/).flatten.first
        @display_name   = page_source.scan(/h1.+title="([^"]+)/).flatten.first
        @display_name   = CGI.unescapeHTML(@display_name) if @display_name
        @data = {
          type: type,
          description: page_source.scan(/profile__content_mainInfo" title="([^"]+)/).flatten.first
        }
        @data[:description] = CGI.unescapeHTML(@data[:description]) if @data[:description]
        self
      rescue => e
        record_error __method__, e.message
        return self
      end

      def find_network_id

      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_avatar

      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_display_name

      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_username

      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_type

      rescue => e
        record_error __method__, e.message
        return nil
      end

      def find_description

      rescue => e
        record_error __method__, e.message
        return nil
      end

      private

      def get_name_and_type(link)
        ind = -1
        splitted = link.split('/')
        type = 'user'
        splitted.each_with_index do |part, i|
          if part == 'community'
            ind = i + 1
            type = 'group'
          elsif part == 'mail'
            ind = i + 1
          end
        end
        name = splitted[ind].split('?').first.split('#').first
        [name, type]
      end

    end
  end
end
