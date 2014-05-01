class IdsPlease
  class Reddit < IdsPlease::BaseParser

    MASK = /reddit/i

    private

    def self.parse_link(link)
      link.path.split('/')[2]
    end

  end
end
