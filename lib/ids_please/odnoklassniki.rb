class IdsPlease
  class Odnoklassniki < IdsPlease::BaseParser

    MASK = /odnoklassniki/i

    def self.parse_link(link)
      if matched = link.path.match(/\/(\d{2,})/)
        matched[1]
      elsif link.path =~ /\/about\//
        link.path.split('/')[-2]
      elsif link.path.split('/').size >= 3
        link.path.split('/')[2]
      end
    end

  end
end
