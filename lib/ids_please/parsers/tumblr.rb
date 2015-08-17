class IdsPlease
  module Parsers
    class Tumblr < IdsPlease::Parsers::Base
      MASK = /tumblr/i

      class << self
        private

        def parse_link(link)
          return if link.host.sub('.tumblr.com', '') == link.host
          link.host.sub('.tumblr.com', '')
        end
      end
    end
  end
end
