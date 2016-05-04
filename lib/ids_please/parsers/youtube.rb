class IdsPlease
  module Parsers
    class Youtube < IdsPlease::Parsers::Base

      MASK = /youtu\.be|youtube/i

      class << self
        def parse_link(link)
          if link.path =~ /channels|user/
            link.path.split('/')[2]
          else
            link.path.split('/')[1]
          end
        end
      end

    end
  end
end
