class IdsPlease
  class GooglePlus < IdsPlease::BaseParser

    MASK = /google/i

    def self.parse(links)
      links.map { |l| parse_link(l) }.compact
    end

    def self.parse_link(link)
      if link.host == 'google.com'
        link.path.split('/')[1]
      else
        matched = link.path.match(/\/(\d{2,})/)
        matched[1] if matched
      end
    end

  end
end
