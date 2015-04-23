class IdsPlease
  class Linkedin < IdsPlease::BaseParser

    MASK = /linkedin/i

    class << self
      private

      def parse_link(link)
        query = CGI.parse(link.query) if link.query && !link.query.empty?

        if query && !query['id'].empty?
          query['id'].first
        elsif link.path =~ /\/in\//
          link.path.split('/')[2]
        elsif link.path =~ /\/company\//
          link.path.split('/')[2]
        end
      end
    end

  end
end
