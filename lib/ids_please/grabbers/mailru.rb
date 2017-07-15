require 'json'

class IdsPlease
  module Grabbers
    class Mailru < IdsPlease::Grabbers::Base
      def grab_link
        @page_source  ||= open(link).read.encode('utf-8')
        uid_url         = "http://appsmail.ru/platform/#{link.path.gsub(/(^\/)|(\/$)/, '')}"
        @network_id     = JSON.parse(open(uid_url).read)['uid']
        @username, type = get_name_and_type(link)

        @avatar         = find_by_regex(/b-history-event__avatar ui-lazy-background\s?".+url\(([^)]+)/)
        @display_name   = find_by_regex(/h1.+title="([^"]+)/) || find_by_regex(/h1\s+itemprop="name"\s+title="([^"]+)/)
        @display_name   = CGI.unescapeHTML(@display_name) if @display_name
        @data = {
          type: type,
          description: find_by_regex(/profile__content_mainInfo" title="([^"]+)/)
        }
        @data[:description] = CGI.unescapeHTML(@data[:description]) if @data[:description]
        self
      rescue => e
        record_error __method__, e.message
        return self
      end

      private

      def get_name_and_type(link)
        ind = -1
        splitted = link.path.gsub(/(^\/)|(\/$)/, '').split('/')
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
