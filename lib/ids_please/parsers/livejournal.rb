class IdsPlease
  module Parsers
    class Livejournal < IdsPlease::Parsers::Base

      MASK = /livejournal/i

      class << self
        def parse_link(link)
          parsed = link.host.sub('.livejournal.com', '')
          parsed = link.host.split('.livejournal').first if parsed == link.host
          return if parsed == link.host
          parsed
        end
      end

    end
  end
end
