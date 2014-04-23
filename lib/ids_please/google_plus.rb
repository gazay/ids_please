class IdsPlease
  class GooglePlus < IdsPlease::BaseParser

    MASK = /google/i

    def self.to_sym
      :google_plus
    end

    def self.parse(links)
      links.map { |l| parse_link(l) }.compact
    end

    private

    def self.parse_link(link)
      if matched = link.path.match(/\/(\+\w+)/)
        matched[1]
      elsif matched = link.path.match(/\/(\d{2,})/)
        matched[1]
      end
    end

  end
end
