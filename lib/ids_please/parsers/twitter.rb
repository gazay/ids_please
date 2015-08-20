class IdsPlease
  module Parsers
    class Twitter < IdsPlease::Parsers::Base

      MASK = /twitter/i

      class << self
        def parse_link(link)
          if link.path =~ /%23!/
            id = link.path.sub(/\A\/%23!\//, '')
            id.split(/[\/\?#]/).first
          else
            super
          end
        end
      end

    end
  end
end
