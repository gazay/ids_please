class IdsPlease
  class Odnoklassniki < IdsPlease::BaseParser

    MASK = /odnoklassniki/i

    def self.parse_link(link)
      if link.path =~ /\/profile\//
        link.path.split('/').last
      elsif link.path.split('/').size == 2
        link.path.split('/').last
      end
    end

  end
end
