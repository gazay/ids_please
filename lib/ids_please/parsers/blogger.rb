class IdsPlease
  module Parsers
    class Blogger < IdsPlease::Parsers::Base
      MASK = /blogspot|blogger/i

      def self.interact(links)
        links.map do |link|
          parse_link(link)
        end.compact
      end

      def self.parse_link(link)
        query = CGI.parse(link.query) if link.query && !link.query.empty?

        if query && !query['blogID'].empty?
          query['blogID'].first.split('#').first
        else
          return if link.host.sub('.blogspot.com', '') == link.host
          link.host.sub('.blogspot.com', '')
        end
      end
    end
  end
end
