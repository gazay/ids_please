class IdsPlease
  module Parsers
    class Hi5 < IdsPlease::Parsers::Base

      MASK = /hi5/i

      class << self
        private

        def parse_link(link)
          query = CGI.parse(link.query) if link.query && !link.query.empty?

          if query && !query['uid'].empty?
            query['uid'].first
          else
            link.path.split('/')[1]
          end
        end
      end

    end
  end
end
