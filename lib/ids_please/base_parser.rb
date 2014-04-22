class IdsPlease
  class BaseParser

    def self.to_sym
      self.name.split('::').last.downcase.to_sym
    end

    def self.parse(links)
      links.map { |l| parse_link(l) }.compact
    end

    private

    def self.parse_link(link)
      link.path.split('/')[1]
    end

  end
end
