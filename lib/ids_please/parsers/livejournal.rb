class IdsPlease
  class Livejournal < IdsPlease::BaseParser

    MASK = /livejournal/i

    class << self
      private

      def parse_link(link)
        parsed = link.host.sub('.livejournal.com', '')
        parsed = link.host.split('.livejournal').first if parsed == link.host
        return if parsed == link.host
        parsed
      end
    end

  end
end
