class IdsPlease
  module Parsers
    class Reddit < IdsPlease::Parsers::Base

      MASK = /reddit/i

      class << self
        def parse_link(link)
          link.path.split('/')[2]
        end
      end

    end
  end
end
