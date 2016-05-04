class IdsPlease
  module Parsers
    class Odnoklassniki < IdsPlease::Parsers::Base

      MASK = /odnoklassniki|ok\.ru/i

      class << self
        def parse_link(link)
          if matched = link.path.match(/\/(\d{2,})/)
            matched[1]
          elsif link.path =~ /\/about\//
            link.path.split('/')[-2]
          elsif link.path.split('/').size >= 3
            link.path.split('/')[2]
          end
        end
      end

    end
  end
end
