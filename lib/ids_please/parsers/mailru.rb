class IdsPlease
  module Parsers
    class Mailru < IdsPlease::Parsers::Base

      MASK = /mail\.ru/i

      class << self
        private

        def parse_link(link)
          id = link.path.split('/')[2]
          id.split('?').first.split('#').first
        end
      end

    end
  end
end
