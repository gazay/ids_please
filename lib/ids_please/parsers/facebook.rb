class IdsPlease
  module Parsers
    class Facebook < IdsPlease::Parsers::Base

      MASK = /fb\.me|fb\.com|facebook/i

      class << self
        def parse_link(link)
          query = CGI.parse(link.query) if link.query && !link.query.empty?

          if query && !query['id'].empty?
            query['id'].first
          elsif link.path =~ /\/pages\//
            link.path.split('/').last
          elsif link.path =~ /\/pg\//
            link.path.split('/pg/')[1].split('/')[0]
          else
            link.path.split('/')[1]
          end
        end
      end

    end
  end
end
