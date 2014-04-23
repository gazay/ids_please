class IdsPlease
  class Moikrug < IdsPlease::BaseParser

    MASK = /moikrug/i

    def self.parse(links)
      links.map do |link|
        next if link.host.sub('.moikrug.ru', '') == link.host
        parse_link(link)
      end.compact
    end

    def self.parse_link(link)
      link.host.sub('.moikrug.ru', '')
    end

  end
end
