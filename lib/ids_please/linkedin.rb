class IdsPlease
  class Linkedin < IdsPlease::BaseParser

    MASK = /linkedin/i

    private

    def self.parse_link(link)
      query = CGI.parse(link.query) if link.query && !link.query.empty?

      if query && !query['id'].empty?
        query['id'].first
      elsif link.path =~ /\/pub\//
        link.path.split('/')[2]
      end
    end


  end
end
