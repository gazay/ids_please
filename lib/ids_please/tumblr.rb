class IdsPlease
  class Tumblr < IdsPlease::BaseParser

    MASK = /tumblr/i

    private

    def self.parse_link(link)
      return if link.host.sub('.tumblr.com', '') == link.host
      link.host.sub('.tumblr.com', '')
    end

  end
end
