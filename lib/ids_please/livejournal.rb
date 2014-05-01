class IdsPlease
  class Livejournal < IdsPlease::BaseParser

    MASK = /livejournal/i

    private

    def self.parse_link(link)
      parsed = link.host.sub('.livejournal.com', '')
      parsed = link.host.split('.livejournal').first if parsed == link.host
      return if parsed == link.host
      parsed
    end

  end
end
