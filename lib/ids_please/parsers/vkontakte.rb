class IdsPlease
  module Parsers
    class Vkontakte < IdsPlease::Parsers::Base

      MASK = /vk\.com|vkontakte|new\.vk\.com/i

      class << self
        def interact(links)
          links.map { |l| parse_link(l) }.compact
        end

        def parse_link(link)
          if link.path =~ /id|club|public/
            id = link.path.sub(/\A\/id|\A\/club|\A\/public/, '')
            id.split(/[\/\?#]/).first
          else
            super
          end
        end
      end

    end
  end
end
