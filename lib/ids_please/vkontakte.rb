class IdsPlease
  class Vkontakte < IdsPlease::BaseParser

    MASK = /vk\.com|vkontakte/i

    def self.parse(links)
      links.map { |l| parse_link(l) }.compact
    end

    def self.parse_link(link)
      if link.path =~ /id|club/
        id = link.path.sub(/\A\/id|\A\/club/, '')
        id.split(/[\/\?#]/).first
      else
        link.path.split('/')[1]
      end
    end

  end
end
