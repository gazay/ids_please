class IdsPlease
  class Vkontakte < IdsPlease::BaseParser

    MASK = /vk\.com|vkontakte/i

    class << self
      def parse(links)
        links.map { |l| parse_link(l) }.compact
      end

      private

      def parse_link(link)
        if link.path =~ /id|club|public/
          id = link.path.sub(/\A\/id|\A\/club|\A\/public/, '')
          id.split(/[\/\?#]/).first
        else
          link.path.split('/')[1]
        end
      end
    end

  end
end
